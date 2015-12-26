//
//  GoingMenberViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/15.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class GoingMenberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var goingMenberTableView = UITableView()
    var receiveStoreName: String?
    var receiveGoingMemberArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationController()
    }
    
    func setNavigationController() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.setMyTitle("Member")
    }
    
    func setUp() {
        let storeNameLabel = UILabel()
        storeNameLabel.backgroundColor = UIColor(red: 252/255, green: 166/255, blue: 51/255, alpha: 1)
        print(receiveStoreName)
        storeNameLabel.text = receiveStoreName!
        storeNameLabel.textColor = UIColor.whiteColor()
        storeNameLabel.font = UIFont(name: (storeNameLabel.font?.fontName)!, size: 23)
        storeNameLabel.textAlignment = NSTextAlignment.Center
        storeNameLabel.frame.size = CGSizeMake(self.view.frame.width, 70)
        storeNameLabel.frame.origin = CGPointMake(0, 0)
        self.view.addSubview(storeNameLabel)
        
        goingMenberTableView.frame.size = CGSizeMake(self.view.frame.width, self.view.frame.height - storeNameLabel.frame.height)
        goingMenberTableView.frame.origin = CGPointMake(0, storeNameLabel.frame.height)
        goingMenberTableView.dataSource = self
        goingMenberTableView.delegate = self
        self.view.addSubview(goingMenberTableView)
        
        self.goingMenberTableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }
    
    //------------------------TableViewControllerSetting-------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let goingMemberFBID = receiveGoingMemberArray[indexPath.section]
        User.getUserWithFBID(goingMemberFBID, callback: { (json) -> Void in
            cell.textLabel?.text = json["name"].string
        })
        
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 0.1
        
        if indexPath.row == 0 {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.accessoryView = UIImageView(image: UIImage(named: "et-line_e021(0)_48"))
        }
        cell.imageView?.frame = CGRectMake(0, 0, 80, 80)
        let profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://graph.facebook.com/\(goingMemberFBID)/picture?type=large")!)!)
        cell.imageView?.image = profileImage
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width)!/2
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiveGoingMemberArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    

    
}
