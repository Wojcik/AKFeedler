//
//  AKItemCell.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/19/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

class AKItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func fillWithItem(item:AKItem){
        self.titleLabel.text = item.title
    }
}
