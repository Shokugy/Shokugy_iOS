//
//  SearchTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/13.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextView.delegate = self
        tableView.registerNib(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        何メートル圏内ごとにセクションをわけてもおもしろいかな?
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
 
   
    @IBAction func tapSearchBtn(sender: UIButton) {
        print("tap")
        searchTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchTextView.resignFirstResponder()
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toStoreDetailViewController", sender: self)
    }

}
