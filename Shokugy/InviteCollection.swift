//
//  InviteCollection.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/23.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InviteCollection: NSObject {
    static let sharedInstance = InviteCollection()
    
    var inviteArray: [Invite] = []
    
    class func getInvites(callback: (JSON) -> Void) {
        let URL = NSURL(string: "http://localhost:3000/api/v1/invites")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            let json = JSON(data: any.data!)["invites"]
            print(any.result)
            callback(json)
        }
    }
    
    class func postInvite(text: String, restaurantID: Int) {
        let params: [String: AnyObject] = [
            "text": text,
            "restaurant_id": restaurantID,
//            "press_time": pressTime
        ]
        
        let URL = NSURL(string: "http://localhost:3000/api/v1/invites/create")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        let request = Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        manager.request(request).responseString { (any) in
            print(any.result)
        }
    }
    

}
