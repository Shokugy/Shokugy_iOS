//
//  GoingMenberViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/15.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class GoingMenberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var goingMenberTableView: UITableView!
    
    var storeName: String?
//    var goingMenber: []

    override func viewDidLoad() {
        super.viewDidLoad()
        storeNameLabel.text = storeName!
        goingMenberTableView.dataSource = self
        goingMenberTableView.delegate = self
        self.navigationItem.title = "Member"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 252/255, green: 221/255, blue: 0/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 0.1
        
        if indexPath.row == 0 {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.accessoryView = UIImageView(image: UIImage(named: "et-line_e021(0)_48"))
        }
        cell.imageView?.frame = CGRectMake(0, 0, 80, 80)
        cell.imageView?.image = UIImage(named: "pug.png")
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width)!/2
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = "soya takahashi"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    

    
}
