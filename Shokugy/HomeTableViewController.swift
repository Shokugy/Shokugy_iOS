//
//  HomeTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/13.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeTableViewController: UITableViewController, HomeTableViewCellDelegate, FBSDKLoginButtonDelegate {
    
    let sampleData = ["soya", "yuya", "kotasawadaIndy"]
    var sampleFav = [1,2,0]
    
    let viewController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //-------FBLoginView----------
        viewController.view.backgroundColor = UIColor.yellowColor()
        let loginBtn = FBSDKLoginButton()
        loginBtn.center = self.view.center
        loginBtn.delegate = self
        viewController.view.addSubview(loginBtn)
        
        self.presentViewController(viewController, animated: true, completion: nil)
        
        
        
        //-----------------------------

        
        tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let rightBarBtn = UIBarButtonItem(image:UIImage(named: "et-line_e021(0)_48"), style: .Plain, target: self, action: "tapRightBarBtn")
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 252/255, green: 221/255, blue: 0/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell") as! HomeTableViewCell
        cell.customDelegate = self
        
        cell.userName.text = sampleData[indexPath.row]
        cell.numOfLike.text = "\(sampleFav[indexPath.row])"
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 96
    }
    
    func tapRightBarBtn() {
        self.performSegueWithIdentifier("ToSearchViewController", sender: self)
    }
    
    func tapFavBtn(sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! HomeTableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        sampleFav[(indexPath?.row)!] += 1
        cell.numOfLike.text = "\(sampleFav[(indexPath?.row)!])"
    }
    
    func tapNumOfFavBtn() {
        let goingMemberViewController = GoingMenberViewController()
        self.navigationController?.pushViewController(goingMemberViewController, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGoingMenberViewController" {
            let goingMenberViewController = segue.destinationViewController as! GoingMenberViewController
            goingMenberViewController.storeName = "すき家　茶屋町店"
        }
    }
    
    func tapStoreNameBtn() {
        let storeDetailViewController = StoreDetailViewController()
        self.navigationController?.pushViewController(storeDetailViewController, animated: true)
    }

    

}
