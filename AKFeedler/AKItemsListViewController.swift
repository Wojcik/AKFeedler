//
//  AKItemsListViewController.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/19/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

class AKItemsListViewController: UITableViewController {

    var feed:AKFeed?
    var loadingView:AKLoadingView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView = AKLoadingView.loadView()
        
        if let view = self.loadingView {
            self.view.addSubview(view)
            let horizontalConstraint = view.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
            let verticalConstraint = view.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor)
            let widthConstraint = view.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor)
            let heightConstraint = view.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor)
            NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        }

        
        let xmlLoader = AKZXMLLoader(networkSession: AKNetworkSession())
        xmlLoader.loadXML { (xml: AKFeed) -> Void in
            self.feed = xml
            self.loadingView?.removeFromSuperview()
            self.tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let path = self.tableView.indexPathForSelectedRow;
        let item = self.feed!.items[(path?.row)!]
        let detailsVC = segue.destinationViewController as! AKItemDetailsViewController 
        detailsVC.item = item
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feed = self.feed {
            print(feed.items.count)
            return feed.items.count
            
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:AKItemCell = tableView.dequeueReusableCellWithIdentifier( "AKItemCell", forIndexPath: indexPath) as! AKItemCell
        let item = self.feed!.items[indexPath.row]
        cell.fillWithItem(item)
        return cell
    }
    
}
