//
//  ReviewCollection.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/22.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire

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
        let userID = Int(review.userID!)
        
        let params: [String: AnyObject] = [
            "review": review.review!,
            "rate": Float(3),
            "restaurant_id": restaurantID,
            "user_id": 1
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/api/v1/reviews/create", parameters: params, encoding: .JSON).responseString { (any) -> Void in
            print(any)
        }
    }


}
