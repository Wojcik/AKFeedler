//
//  File.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/15/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import Foundation

typealias CompletionBlock = (NSData?, String?) -> Void

class AKNetworkSession
{
    func httpGet(resourcePath: String!, callback: CompletionBlock){
        let resourceURL:NSURL! = NSURL(string: resourcePath)
        let request = NSURLRequest(URL: resourceURL)
        self.httpGet(request, callback:callback)
    }

    func httpGet(request: NSURLRequest!, callback: CompletionBlock) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    callback(nil, error!.localizedDescription)
                } else {
                    callback(data, nil)
                }
            }

        }
        task.resume()
    }
}