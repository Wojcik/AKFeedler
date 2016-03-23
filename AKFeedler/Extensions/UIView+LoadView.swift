//
//  UIView+LoadView.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/24/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

extension UIView {
    class func loadView() -> UIView? {
        let mainBundle = NSBundle.init(forClass: self)
        let view = mainBundle.loadNibNamed(String(self), owner: self, options: nil).first as? UIView
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
