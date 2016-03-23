//
//  AKNothingToDisplayView.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/24/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

protocol AKReloadDelegate {
    func reload() -> Void
}

class AKNothingToDisplayView: UIView {
    
    var delegate:AKReloadDelegate?
    @IBOutlet weak var label: UILabel!
    
    @IBAction func repeatButtonTapped(sender: UIButton) {
        self.delegate?.reload()
    }
}
