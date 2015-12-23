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
    var restaurantArray: [Restaurant] = []
    var sendRestaurant: Restaurant!
    var restaurantsJSON: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSeachTextField()
        
        tableView.registerNib(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavBar()
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView = searchTextField
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .Done, target: self, action: "tapSearchBtn")
    }
    
    func tapSearchBtn() {
        RestaurantManager.searchRestraunt(searchTextField.text!) { (json) -> Void in
            for i in 0..<json.count {
                self.makeRestaurant(json[i])
            }
            
            self.tableView.reloadData()
        }
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let storeDetailViewController = segue.destinationViewController as! StoreDetailViewController
        storeDetailViewController.receiveRestaurant = sendRestaurant
    }
    
    func makeRestaurant(restaurantJSON: JSON) {
        let restaurant = Restaurant()
        restaurant.restaurantID = restaurantJSON["id"].int
        restaurant.name = restaurantJSON["name"].string
        restaurant.nameKana = restaurantJSON["nameKana"].string
        restaurant.link = restaurantJSON["link"].string
        restaurant.imageURL = restaurantJSON["imageURL"].string
        restaurant.addres = restaurantJSON["address"].string
        
        restaurantArray.append(restaurant)
    }
    
    //-------------TableViewSetting-----------------------------------

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return restaurantArray.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell") as! SearchTableViewCell
        let restaurant = restaurantArray[indexPath.section]
        
        cell.storeNameLabel.text = restaurant.name
        cell.storeAccessLabel.text = restaurant.addres
//        cell.storeDistanceLabel.text
        let imageURL = NSURL(string: restaurant.imageURL!)
        let imageData = NSData(contentsOfURL: imageURL!)
        cell.rateImageView.image = UIImage(data: imageData!)
        
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sendRestaurant = restaurantArray[indexPath.section]
        print(sendRestaurant.name)
        self.performSegueWithIdentifier("SegueToStoreDetailViewController", sender: self)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 6
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 10 {
            return 6
        } else {
            return 3
        }
    }


}
