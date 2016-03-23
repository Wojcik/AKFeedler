//
//  AKItem.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/19/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import Foundation

class AKItem {
    var title: String = ""
    var link: String = ""
    var pubDate: String = ""
    var description: String = ""
    
    func appendElement (element:AKItemAssembly!) {
        switch element.elementName {
        case "title":
            self.title = element.elementContents
        case "link" :
            self.link = element.elementContents
        case "pubDate" :
            self.pubDate = element.elementContents
        case "description":
            self.description = element.elementContents
        default:
            break
        }
    }
}