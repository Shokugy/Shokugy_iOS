//
//  NotificationManager.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/26.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotificationManager: NSObject {
    
    class func getNotification(callback: (JSON) -> Void) {
        let URL = NSURL(string: "http://localhost:3000/api/v1/notifications")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            print(any.result)
            print(JSON(data: any.data!))
            let json = JSON(data: any.data!)["notifications"]
            callback(json)
        }
    }

}
