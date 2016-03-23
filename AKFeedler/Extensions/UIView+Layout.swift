//
//  LayoutConstructor.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/24/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

extension UIView {
    func fillView(view:UIView) {
        let horizontalConstraint = self.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let verticalConstraint = self.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
        let widthConstraint = self.widthAnchor.constraintEqualToAnchor(view.widthAnchor)
        let heightConstraint = self.heightAnchor.constraintEqualToAnchor(view.heightAnchor)
        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}