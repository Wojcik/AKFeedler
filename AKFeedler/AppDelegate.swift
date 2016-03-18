//
//  AppDelegate.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/15/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit
import Foundation
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let xmlLoader = AKZXMLLoader(networkSession: AKNetworkSession())
        xmlLoader.loadXML { (xml: AKFeed) -> Void in

        }

        // Override point for customization after application launch.
        return true
    }


}

