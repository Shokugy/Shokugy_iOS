//
//  Review.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/22.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class Review: NSObject {
    
    var userID: String?
    var restaurantID: Int?
    var rate: Float?
    var review: String?
//    var numOfLike: Int?
    var postTime: String?
    
    
    //------userViewのみ------
    
    var restaurantName: String?
    var restaurantAddress: String?   

}
