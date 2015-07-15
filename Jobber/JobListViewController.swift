//
//  JobsTableViewController.swift
//  Jobber
//
//  Created by Andela Developer on 7/6/15.
//  Copyright (c) 2015 Andela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



enum Storyboard {
    static let CellReuseIdentifier = "JobCell"
}


class JobListViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var availableJobs = [Job]()
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        fetchJobs()
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsScopeBar = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.sizeToFit()
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsScopeBar = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.sizeToFit()
        return true
    }
 
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.text = "ios"
    }
    
    func configureTableView() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.setContentOffset(CGPointMake(0.0, self.tableView.tableHeaderView!.frame.size.height), animated: true)
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        sender.beginRefreshing()
        fetchJobs()
    }
    
    func fetchJobs() {
        request(.GET, "http://api.indeed.com/ads/apisearch?publisher=1250343143571133&l=stanford&sort=&radius=&st=&jt=&start=&limit=100&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&format=json&v=2&q=" + searchBar.text, encoding: .JSON)
        .responseJSON { (request, response, data, error) in
            if error != nil {
                println(error)
            } else if data == nil {
                println("no data")
            } else {
                if let jobs = (data as! NSDictionary)["results"] as? NSArray {
                    self.availableJobs.removeAll(keepCapacity: false)
                    for job in jobs {
                        let newJob = Job(job: job as! NSDictionary)
                        self.availableJobs.append(newJob)
                    }
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        fetchJobs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return availableJobs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! JobTableViewCell

        // Configure the cell...
        cell.job = availableJobs[indexPath.row]
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }

}
