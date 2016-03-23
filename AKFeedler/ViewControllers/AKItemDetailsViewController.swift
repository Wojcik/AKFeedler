//
//  AKItemDetailsViewController.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/19/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

class AKItemDetailsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var item:AKItem?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.loadHTMLString(self.item!.description, baseURL: NSURL(string: ""))
    }

    override func viewWillAppear(animated: Bool) {
        self.title = self.item?.title
    }

}
