//
//  SearchTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/13.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchTableViewController: UITableViewController, UITextFieldDelegate {
    
    let searchTextField = UITextField()
    let searchBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSeachTextField()
        tableView.registerNib(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
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
        self.navigationItem.titleView = searchTextField
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .Done, target: self, action: "tapSearchBtn")
    }
    
    func tapSearchBtn() {
        RestaurantManager.searchRestraunt(searchTextField.text!)
        searchTextField.resignFirstResponder()
    }
    
    func setSeachTextField() {
        searchTextField.frame.size = CGSizeMake(250, 25)
        searchTextField.backgroundColor = UIColor.whiteColor()
        searchTextField.layer.cornerRadius = 3
        searchTextField.placeholder = "search"
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .Always

        searchTextField.delegate = self
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    //-------------TableViewSetting---------

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        何メートル圏内ごとにセクションをわけてもおもしろいかな?
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell") as! SearchTableViewCell
        
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storeDetailViewController = StoreDetailViewController()
        self.navigationController?.pushViewController(storeDetailViewController, animated: true)
    }

}
