//
//  UserViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/19.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let selfCommentTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "setting.png"), style: UIBarButtonItemStyle.Done, target: self, action: "tapSettingBtn")
    }
    
    func tapSettingBtn() {
        print("tapSetting")
    }
    
    func setUp() {
        let userCoverView = UIView()
        userCoverView.frame.size = CGSizeMake(self.view.frame.width, 180)
        userCoverView.frame.origin = CGPointMake(0, 0)
        userCoverView.backgroundColor = UIColor(red: 252/255, green: 230/255, blue: 102/255, alpha: 1)
        self.view.addSubview(userCoverView)
        
        let userImageView = UIImageView()
        userImageView.image = UIImage(named: "pug.png")
        userImageView.frame.size = CGSizeMake(100, 100)
        userImageView.center.x = self.view.center.x
        userImageView.frame.origin.y = 20
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userCoverView.addSubview(userImageView)
        
        let userImageViewWhiteCover = UIView()
        userImageViewWhiteCover.backgroundColor = UIColor.whiteColor()
        userImageViewWhiteCover.frame.size = CGSizeMake(105, 105)
        userImageViewWhiteCover.center = userImageView.center
        userImageViewWhiteCover.layer.cornerRadius = userImageViewWhiteCover.frame.width/2
        userCoverView.addSubview(userImageViewWhiteCover)
        userCoverView.bringSubviewToFront(userImageView)
        
        let userNameLabel = UILabel()
        userNameLabel.text = "Soya Takahahshi"
        userNameLabel.textAlignment = NSTextAlignment.Center
        userNameLabel.sizeToFit()
        userNameLabel.center = CGPointMake(self.view.center.x, 135)
        userCoverView.addSubview(userNameLabel)
        
        let numOfCommentLabel = UILabel()
        numOfCommentLabel.text = "１２口コミ"
        numOfCommentLabel.font = UIFont(name: (numOfCommentLabel.font?.fontName)!, size: 15)
        numOfCommentLabel.textAlignment = NSTextAlignment.Center
        numOfCommentLabel.sizeToFit()
        numOfCommentLabel.center = CGPointMake(self.view.center.x, 160)
        userCoverView.addSubview(numOfCommentLabel)
        
        userCoverView.addSubview(makeBtn(self.view.center.x-90, tag: 1, image: UIImage(named: "member.png")!))
        userCoverView.addSubview(makeBtn(self.view.center.x+85, tag: 2, image: UIImage(named: "change.png")!))
        
        selfCommentTableView.frame.size = CGSizeMake(self.view.frame.width, self.view.frame.height-180)
        selfCommentTableView.frame.origin = CGPointMake(0, 180)
        selfCommentTableView.delegate = self
        selfCommentTableView.dataSource = self
        selfCommentTableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        selfCommentTableView.scrollEnabled = true
        self.view.addSubview(selfCommentTableView)
    }
    
    func makeBtn(x: CGFloat, tag: Int, image: UIImage) -> UIButton {
        let button = UIButton()
        button.frame.size = CGSizeMake(40, 40)
        button.center.y = 70
        button.center.x = x
        button.tag = tag
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: "tapBtn:", forControlEvents: .TouchUpInside)
        return button
    }
    
    let navController = UINavigationController()

    func tapBtn(sender: UIButton) {
        if sender.tag == 1 {
            navController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
            navController.navigationBar.translucent = false
            
            let memberTableViewController = AddMemberTableViewController()
            navController.setViewControllers([memberTableViewController], animated: true)
            memberTableViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "tapNavCancelBtn")
            
            self.presentViewController(navController, animated: true, completion: nil)
        } else if sender.tag == 2 {
            print("tapChange")
        }
    }
    
    func tapNavCancelBtn() {
        navController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //---------------TableViewSetting-----------
    
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

}
