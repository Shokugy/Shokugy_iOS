//
//  UserViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/19.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var numOfCommentLabel: UILabel!
    @IBOutlet weak var selfCommentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.clipsToBounds = true  
        selfCommentTableView.delegate = self
        selfCommentTableView.dataSource = self
        self.selfCommentTableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = selfCommentTableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! HomeTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 96
    }

    @IBAction func tapSettingBtn(sender: UIButton) {
    }
    
    let navController = UINavigationController()

    @IBAction func tapMemberBtn(sender: UIButton) {
        navController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        navController.navigationBar.translucent = false
        
        let memberTableViewController = AddMemberTableViewController()
        navController.setViewControllers([memberTableViewController], animated: true)
        memberTableViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "tapNavCancelBtn")
        
        self.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    @IBAction func tapChangeBtn(sender: UIButton) {
    }
    
    func tapNavCancelBtn() {
        navController.dismissViewControllerAnimated(true, completion: nil)

    }
    
}
