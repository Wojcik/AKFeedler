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

    init(networkSession:AKNetworkSession){
        self.networkSession = networkSession
    }

    func loadXML(completion:XMLLoadingCompletion!) -> Void {
        self.xmlLoadingComletion = completion
        self.networkSession.httpGet(AKConstants.feedPath) { (result, error) -> Void in
            if let xmlData = result {
                let parser = NSXMLParser(data: xmlData)
                parser.delegate = self
                parser.parse()
            }
        }
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        print(elementName)
//        element = elementName
//        if (elementName as NSString).isEqualToString("item")
//        {
//            elements = NSMutableDictionary()
//            elements = [:]
//            title1 = NSMutableString()
//            title1 = ""
//            date = NSMutableString()
//            date = ""
//        }
    }

    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        print(string)
//        if element.isEqualToString("title") {
//            title1.appendString(string)
//        } else if element.isEqualToString("pubDate") {
//            date.appendString(string)
//        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        print(elementName)
//        if (elementName as NSString).isEqualToString("item") {
//            if !title1.isEqual(nil) {
//                elements.setObject(title1, forKey: "title")
//            }
//            if !date.isEqual(nil) {
//                elements.setObject(date, forKey: "date")
//            }
//
//            posts.addObject(elements)
//        }
    }

    func parserDidEndDocument(parser: NSXMLParser) {
        self.xmlLoadingComletion!(xml: self.xml)
    }
}
