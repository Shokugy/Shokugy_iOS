//
//  LikeRestaurantTableViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/26.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import SwiftyJSON

class LikeRestaurantTableViewController: UITableViewController {
    
    var restaurants: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        //---------
        RestaurantManager.getFavoriteRestaurants { (json) -> Void in
            self.restaurants = []
            for i in 0 ..< json.count {
                self.makeRestaurant(json[i])
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeRestaurant(json: JSON) {
        let restaurant = Restaurant()
        restaurant.restaurantID = json["id"].int
        restaurant.name = json["name"].string
        restaurant.nameKana = json["nameKana"].string
        restaurant.link = json["link"].string
        restaurant.imageURL = json["imageURL"].string
        restaurant.addres = json["address"].string
        
        restaurants.append(restaurant)
    }
    
    func setUp() {
        self.tableView.registerNib(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
        self.navigationItem.setMyTitle("Your Favorite")
        
        
    }


    
    
    //-------tableviewSetting ---------------------
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print(restaurants.count)
        return restaurants.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SearchTableViewCell
        let restaurant = restaurants[indexPath.section]
        
        cell.storeNameLabel.text = restaurant.name
        cell.storeAccessLabel.text = restaurant.addres
        cell.storeDistanceLabel.text = "50m"
        let imageURL = NSURL(string: restaurant.imageURL!)
        let imageData = NSData(contentsOfURL: imageURL!)
        cell.rateImageView.image = UIImage(data: imageData!)
        cell.rateImageView.contentMode = UIViewContentMode.ScaleAspectFill
//        cell.averageRateLabel
        
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        cell.selectionStyle = .None
        
        
        
        return cell
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
