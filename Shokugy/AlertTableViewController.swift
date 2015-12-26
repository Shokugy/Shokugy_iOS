//
//  AlertTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/13.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import SwiftyJSON

class AlertTableViewController: UITableViewController {
    
    var notifications: [Notification] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "AlertTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavBar()
        
        NotificationManager.getNotification { (json) -> Void in
            self.notifications = []
            for i in 0 ..< json.count {
                self.makeNotification(json[i])
            }
            self.tableView.reloadData()
        }
    }
    
    func makeNotification(json: JSON) {
        let notification = Notification()
        notification.content = json["content"].string
        notification.date = json["date"].string
        
        notifications.append(notification)
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.setMyTitle("Shokugy")
    }

    //----------------------------TableViewSetting------------------------------
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return notifications.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell") as! AlertTableViewCell
        let notification = notifications[indexPath.section]
        
        cell.alertDetail.text = notification.content!
        cell.alertTime.text = notification.date!
        
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 0.1
        
        cell.alertImage.image = UIImage(named: "invite")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 5
        } else {
            return 2.5
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 10 {
            return 5
        } else {
            return 2.5
        }
    }

}
