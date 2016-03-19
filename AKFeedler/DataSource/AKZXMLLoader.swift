//
// Created by Anton Kovalev on 3/17/16.
// Copyright (c) 2016 Anton Kovalev. All rights reserved.
//

import Foundation

typealias XMLLoadingCompletion = (xml:AKFeed)-> Void

class AKZXMLLoader : NSObject, NSXMLParserDelegate {
    let networkSession:AKNetworkSession

    var xmlLoadingComletion:XMLLoadingCompletion?
    lazy var xml: AKFeed = AKFeed()

    var currentItem: AKItem?
    var itemAssembly:AKItemAssembly?
    
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
        case "item":
            self.currentItem = AKItem()
        default:
            if let _ = self.currentItem {
                self.itemAssembly = AKItemAssembly()
                self.itemAssembly?.elementName = elementName
            }
            break
        }
    }

    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        self.itemAssembly?.elementContents += string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        switch elementName {
        case "item":
            self.xml.items.append(self.currentItem!)
            self.currentItem = nil
        default :
            if let _ = self.currentItem {
                self.currentItem!.appendElement(self.itemAssembly!)
                self.itemAssembly = nil
            }
        }
    }

    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue()) {
            self.xmlLoadingComletion!(xml: self.xml)
        }
    }
}
