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
        
        Alamofire.request(.POST, "http://localhost:3000/", parameters: params, encoding: .JSON).responseString { (any) -> Void in
            print(any)
        }
        
    }

}