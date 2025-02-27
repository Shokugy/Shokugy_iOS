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
    
    class func fetchRestaurant(id: Int, callback: (JSON) -> Void) {
        let URL = NSURL(string: "http://localhost:3000/api/v1/restaurants/\(id)")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            let json = JSON(data: any.data!)
            
            callback(json)
        }
    }
    
    class func getRestaurantRanking() {
        let URL = NSURL(string: "http://localhost:3000/api/v1/restaurants/ranking")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            print(JSON(data: any.data!))
            print(any.result)
        }
    }
    
    class func postFavoriteRestaurant(restaurantID: Int) {
        let params: [String: AnyObject] = [
            "restaurant_id": restaurantID
        ]
        let URL = NSURL(string: "http://localhost:3000/api/v1/restaurants/favorite")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        let request = Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        manager.request(request).responseString { (any) in
            print(any.result)
            print(JSON(data: any.data!))
//            callback()
        }
    }
    
    class func getFavoriteRestaurants(callback: (JSON) -> Void) {
        let URL = NSURL(string: "http://localhost:3000/api/v1/restaurants/favorite")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            print(any.result)
            print(JSON(data: any.data!))
            let json = JSON(data: any.data!)["restaurants"]
            callback(json)
        }

    }

}

