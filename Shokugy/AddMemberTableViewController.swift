//
//  AddMemberTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/18.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class AddMemberTableViewController: UITableViewController {
    
    let sectionTitleAry: [String] = ["hoe", "piyo", "hogehoge"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleAry[section]
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.imageView?.image = UIImage(named: "pug.png")
        cell.imageView?.clipsToBounds = true
        cell.imageView?.frame.size = CGSizeMake(30, 30)
        cell.textLabel?.text = "soYa takahashi"
        cell.imageView?.layer.cornerRadius = 22
        cell.imageView?.layer.masksToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryType == .Checkmark {
            cell?.accessoryType = .None
        } else {
            cell?.accessoryType = .Checkmark
        }
        
        print(indexPath)
        //タップされたインデックスを配列で管理してメンバーを（ry
    }
    
    

    
}