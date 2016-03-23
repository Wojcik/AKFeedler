//
// Created by Anton Kovalev on 3/18/16.
// Copyright (c) 2016 Anton Kovalev. All rights reserved.
//

import Foundation

class AKFeed {
    // MARK: -refactor this 
    var gettingChannelInfo = false
    var waitingForTitle = false
    var title: String! = ""
    var items = [AKItem]()
}
