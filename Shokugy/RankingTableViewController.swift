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
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavBar()
        
        //----------test------
        print("===================")
        RestaurantManager.getRestaurantRanking()
        print("===================")
        //---------------------
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.setMyTitle("Shokugy")
    }
    
    //--------------------------TableViewSetting-----------------------------------

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! RankingTableViewCell
        cell.rankingNumLabel.text = "\(indexPath.row+1)"
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        cell.rateImageView.image = UIImage(named: "rate3")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 6
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 10 {
            return 6
        } else {
            return 3
        }
    }


}
