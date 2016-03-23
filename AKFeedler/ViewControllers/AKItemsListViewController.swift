//
//  AKItemsListViewController.swift
//  AKFeedler
//
//  Created by Anton Kovalev on 3/19/16.
//  Copyright © 2016 Anton Kovalev. All rights reserved.
//

import UIKit

class AKItemsListViewController: UITableViewController, AKReloadDelegate {

    var feed:AKFeed?
    lazy var loadingView:AKLoadingView! = {
        return AKLoadingView.loadView() as! AKLoadingView
    }()
    lazy var nothingToShowView:AKNothingToDisplayView? = {
        return AKNothingToDisplayView.loadView() as? AKNothingToDisplayView
    }()
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadItems()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let path = self.tableView.indexPathForSelectedRow;
        let item = self.feed!.items[(path?.row)!]
        let detailsVC = segue.destinationViewController as! AKItemDetailsViewController 
        detailsVC.item = item
    }
    
    // MARK: - table view data source 
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
        let cell:AKItemCell = tableView.dequeueReusableCellWithIdentifier( String(AKItemCell), forIndexPath: indexPath) as! AKItemCell
        let item = self.feed!.items[indexPath.row]
        cell.fillWithItem(item)
        return cell
    }
    
    // MARK: - AKReloadDelegate 
    func reload() {
        self.loadItems()
    }
    
    //MARK : - private
    
    func loadItems () -> Void
    {
        self.view.addSubview(self.loadingView)
        self.loadingView.fillView(self.view)
        
        let xmlLoader = AKZXMLLoader(networkSession: AKNetworkSession())
        xmlLoader.loadXML { xml in
            self.feed = xml
            self.title = self.feed?.title
            self.loadingView.removeFromSuperview()
            if xml != nil {
                self.nothingToShowView?.removeFromSuperview()
                self.tableView.reloadData()
            } else {
                self.nothingToShowView?.delegate = self
                self.view.addSubview(self.nothingToShowView!)
                self.nothingToShowView!.fillView(self.view)
            }
        }
    }
    
}
