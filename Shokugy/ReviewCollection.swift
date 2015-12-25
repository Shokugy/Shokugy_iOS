//
//  ReviewCollection.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/22.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReviewCollection: NSObject {
    
    var reviewArray: [Review] = []
    
    func getReview() {
        for _ in 1...10 {
            let review = Review()
            
            review.userID = "1"
            review.restaurantID = 1
            review.rate = 4
            review.review = "さいこうまじさいこう"
//            review.numOfLike = 2
            review.postTime = "2015/12/24"
            
            reviewArray.append(review)
        }
    }
    
    class func saveReview(review: Review) {
        let restaurantID = Int(review.restaurantID!)
        
        let params: [String: AnyObject] = [
            "review": review.review!,
            "rate": Float(3),
            "restaurant_id": restaurantID,
        ]
        
        let URL = NSURL(string: "http://localhost:3000/api/v1/reviews/create")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        let request = Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        manager.request(request).responseString { (any) in
                print(any)
        }
    }
    
    class func getMypageReview(callback: (JSON) -> Void) {
        let URL = NSURL(string: "http://localhost:3000/api/v1/reviews/mypage")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            print(JSON(data: any.data!))
            let json = JSON(data: any.data!)["reviews"]
            callback(json)
        }
    }
    
    class func getRestaurantReviews() {
        let URL = NSURL(string: "http://localhost:3000/api/v1/reviews")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            print(JSON(data: any.data!))
//            let json = JSON(data: any.data!)["reviews"]
//            callback(json)
        }

    }


}
