//
//  RankingTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/20.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class RankingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! RankingTableViewCell
        cell.rankingNumLabel.text = "\(indexPath.row+1)"
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}
