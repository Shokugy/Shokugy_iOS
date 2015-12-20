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

    class func searchRestraunt(searchWord: String) {
        
        let params: [String: AnyObject] = [
            "name": searchWord
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/api/v1/restaurants/search", parameters: params, encoding: .JSON).responseJSON { (any) -> Void in
            print("hoge")
        }
    }

}
