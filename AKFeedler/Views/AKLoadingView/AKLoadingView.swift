//
//  AKLoadingView.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/19/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

class AKLoadingView: UIView {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    class func loadView() -> AKLoadingView? {
        let mainBundle = NSBundle.init(forClass: self)
        let view = mainBundle.loadNibNamed(String(self), owner: self, options: nil).first as! AKLoadingView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
