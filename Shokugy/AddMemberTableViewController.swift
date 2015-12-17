//
//  AddMemberTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/18.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class AddMemberTableViewController: UITableViewController {
    
    let sectionTitleAry: [String] = ["hoe", "piyo", "hogehoge", "a", "b", "c", "d", "e", "f", "g", "h", "i"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitleAry.count
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
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
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
    
    //--------------sectionindex-----------
//    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        return sectionTitleAry
//    }
    
}
