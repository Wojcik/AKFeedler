//
//  File.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/15/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import Foundation

class AKDataSource: NSObject
{
    class func httpGet(request: NSURLRequest!, callback: (NSData?, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback(nil, error!.localizedDescription)
            } else {
                callback(data, nil)
            }
        }
        task.resume()
    }
}