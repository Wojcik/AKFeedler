//
// Created by Anton Kovalev on 3/17/16.
// Copyright (c) 2016 Anton Kovalev. All rights reserved.
//

import Foundation

typealias XMLLoadingCompletion = (xml:AKFeed?)-> Void

class AKZXMLLoader : NSObject, NSXMLParserDelegate {
    let networkSession:AKNetworkSession

    var xmlLoadingComletion:XMLLoadingCompletion?
    lazy var xml: AKFeed = AKFeed()

    var currentItem: AKItem?
    var itemAssemblys:[AKItemAssembly]! = []
    
    // MARK: main routine
    init(networkSession:AKNetworkSession){
        self.networkSession = networkSession
    }

    func loadXML(completion:XMLLoadingCompletion!) -> Void {
        self.xmlLoadingComletion = completion
        self.networkSession.httpGet(AKConstants.feedPath) { (result, error) -> Void in
            if let xmlData = result {
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    let parser = NSXMLParser(data: xmlData)
                    parser.delegate = self
                    parser.parse()
                }
            }
        }
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        switch elementName {
        case "channel":
            self.xml.gettingChannelInfo = true
        case "title" where self.xml.gettingChannelInfo == true:
            self.xml.waitingForTitle = true
        case "item":
            self.currentItem = AKItem()
        default:
            if let _ = self.currentItem {
                let currentAssembly = AKItemAssembly()
                currentAssembly.elementName = elementName
                self.itemAssemblys.append(currentAssembly)
            }
        }
    }

    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if self.xml.waitingForTitle && self.xml.gettingChannelInfo {
            self.xml.title! += string
            return
        }
        let currentAssembly = self.itemAssemblys.last
        currentAssembly?.elementContents += string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        switch elementName {
        case "title" where self.xml.gettingChannelInfo == true:
            self.xml.waitingForTitle = false
            self.xml.gettingChannelInfo = false
        case "item":
            self.xml.items.append(self.currentItem!)
            self.itemAssemblys.removeAll()
            self.currentItem = nil
        default :
            if let _ = self.currentItem {
                self.currentItem!.appendElement(self.itemAssemblys.removeLast())
            }
        }
    }

    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue()) {
            self.xmlLoadingComletion!(xml: self.xml)
        }
    }
    
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        dispatch_async(dispatch_get_main_queue()) {
            self.xmlLoadingComletion!(xml: nil)
        }
    }

}
