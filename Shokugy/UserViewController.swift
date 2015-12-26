//
//  UserViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/19.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FBSDKLoginButtonDelegate {
    
    let selfCommentTableView = UITableView()
    let settingView = UIView()
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    var isPutSettingView: Bool = true
    let user = User.currentUser
    var reviews: [Review] = []
    var sendRestaurantID: Int?
    
    var hogecounter = 2 //ごまかし用
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reviews = []
        ReviewCollection.getMypageReview { (json) -> Void in
            for i in 0 ..< json.count {
                self.makeReview(json[i])
            }
            
            self.selfCommentTableView.reloadData()
        }
        setNavBar()
        
        hogecounter = 2 //ごまかし用
    }
    
    func makeReview(reviewJSON: JSON) {
        let review = Review()
        review.review = reviewJSON["review"].string
        review.restaurantName = reviewJSON["restaurantName"].string
        review.restaurantAddress = reviewJSON["restaurantAddress"].string
        review.restaurantID = reviewJSON["restaurantId"].int
        reviews.append(review)
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "setting.png"), style: UIBarButtonItemStyle.Done, target: self, action: "tapSettingBtn")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "change.png"), style: .Done, target: self, action: "tapChangeButton")
    }
    
    func tapChangeButton() {
        print("tapChange")
        self.performSegueWithIdentifier("ToGroupViewController", sender: self)
    }
    
    func setUser() {
        userImageView.image = user.avatar!
        userNameLabel.text = user.name!
    }
    
    func setUp() {
        let userCoverView = UIView()
        userCoverView.frame.size = CGSizeMake(self.view.frame.width, 180)
        userCoverView.frame.origin = CGPointMake(0, 0)
        userCoverView.backgroundColor = UIColor(red: 252/255, green: 166/255, blue: 51/255, alpha: 1)
        self.view.addSubview(userCoverView)
        
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
    
        userNameLabel.text = "Soya Takahahshi"
        userNameLabel.textColor = UIColor.whiteColor()
        userNameLabel.textAlignment = NSTextAlignment.Center
        userNameLabel.sizeToFit()
        userNameLabel.center = CGPointMake(self.view.center.x, 135)
        userCoverView.addSubview(userNameLabel)
        
        let numOfCommentLabel = UILabel()
        numOfCommentLabel.text = "12口コミ"
        numOfCommentLabel.textColor = UIColor.whiteColor()
        numOfCommentLabel.font = UIFont(name: (numOfCommentLabel.font?.fontName)!, size: 15)
        numOfCommentLabel.textAlignment = NSTextAlignment.Center
        numOfCommentLabel.sizeToFit()
        numOfCommentLabel.center = CGPointMake(self.view.center.x, 160)
        userCoverView.addSubview(numOfCommentLabel)
        
        var image = UIImage(named: "member.png")?.imageWithRenderingMode(.AlwaysTemplate)
        userCoverView.addSubview(makeBtn(self.view.center.x-100, tag: 1, image: image!))
        image = UIImage(named: "like.png")?.imageWithRenderingMode(.AlwaysTemplate)
        userCoverView.addSubview(makeBtn(self.view.center.x+90, tag: 2, image: image!))
        
        selfCommentTableView.frame.size = CGSizeMake(self.view.frame.width, self.view.frame.height - userCoverView.frame.height - 64 - 49)
        selfCommentTableView.frame.origin = CGPointMake(0, 180)
        selfCommentTableView.delegate = self
        selfCommentTableView.dataSource = self
        selfCommentTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        selfCommentTableView.scrollEnabled = true
        self.view.addSubview(selfCommentTableView)
        
        self.selfCommentTableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }
    
    func makeBtn(x: CGFloat, tag: Int, image: UIImage) -> UIButton {
        let button = UIButton()
        button.frame.size = CGSizeMake(44, 44)
        button.center.y = 85
        button.center.x = x
        button.tag = tag
        button.setImage(image, forState: .Normal)
        button.tintColor = UIColor.whiteColor()
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
            self.performSegueWithIdentifier("LikeRestaurantTableViewController", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToStoreDetailViewController" {
        let storeDetailViewController = segue.destinationViewController as! StoreDetailViewController
        storeDetailViewController.receiveRestaurantID = sendRestaurantID
            print(sendRestaurantID)
        }
    }
    
    func tapNavCancelBtn() {
        navController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //---------------------------TableViewSetting-------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = selfCommentTableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CommentTableViewCell
        
        let review = reviews[indexPath.section]
        cell.userName.text = User.currentUser.name
        cell.userImageView.image = User.currentUser.avatar
        cell.rateImageView.image = UIImage(named: "stars_4")
        cell.userReviewLabel.text = review.review
        cell.storeNameLabel.text = review.restaurantName
        cell.storeAccessLabel.text = review.restaurantAddress
        cell.postDateLabel.text = String(hogecounter) + "時間前"
        hogecounter += 3
        
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 6
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 12 {
            return 6
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sendRestaurantID = reviews[indexPath.section].restaurantID
        self.performSegueWithIdentifier("ToStoreDetailViewController", sender: self)
    }
    
    //---------------------settingView----------------------------------
    
    func tapSettingBtn() {
        if isPutSettingView {
            setSettingView()
            
            UIView.animateWithDuration(0.3) { () -> Void in
                self.settingView.frame.origin = CGPointZero
            }
            
            isPutSettingView = false
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.settingView.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
                }, completion: { (finished) -> Void in
                    self.settingView.removeFromSuperview()
            })
            
            isPutSettingView = true
        }
    }
    
    func setSettingView() {
        settingView.frame.size = self.view.frame.size
        settingView.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
        settingView.backgroundColor = UIColor(red: 252/255, green: 166/255, blue: 51/255, alpha: 1)
        
        let logoutBtn = FBSDKLoginButton()
        logoutBtn.center.x = self.view.center.x
        logoutBtn.center.y = self.view.frame.height / CGFloat(2)
        logoutBtn.delegate = self
        settingView.addSubview(logoutBtn)
        
        self.view.addSubview(settingView)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("logout")
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.removeObjectForKey("user")
        settingView.removeFromSuperview()
        self.tabBarController?.selectedIndex = 0
    }


}
