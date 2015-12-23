//
//  RestaurantManager.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/14.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RestaurantManager: NSObject {

    class func searchRestraunt(searchWord: String, callback: (JSON) -> Void) {
        let params: [String: AnyObject] = [
            "name": searchWord
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/api/v1/restaurants/search", parameters: params, encoding: .JSON).responseJSON { (any) -> Void in
            let json = JSON(data: any.data!)["restaurants"]
            callback(json) 
        }
        
    }
    
    class func fetchRestaurant(id: Int) -> Restaurant {
        //id をもとにデータをとってくる
        print("get data from server")
        let restaurant = Restaurant()
        restaurant.restaurantID = 1
        restaurant.name = "すき家"
        restaurant.nameKana = "すきや"
        restaurant.link = "hogehoge"
        restaurant.imageURL = "http://jobs.sukiya.jp/images/top/top_visual.png"
        restaurant.addres = "大阪市中崎町うん"
        
        return restaurant
    }

}

