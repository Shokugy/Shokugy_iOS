//
//  InviteCollection.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/23.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire

class InviteCollection: NSObject {
    static let sharedInstance = InviteCollection()
    
    var inviteArray: [Invite] = []
    
    func getInvites() {
        for _ in 1...10 {
            let invite = Invite()
            invite.storeName = "すきや"
            invite.access = "大阪市北区"
            invite.comment = "いきましょー"
            invite.postTime = "5分前"
            invite.userID = "1"
            invite.restaurantID = 1
            invite.goingMemberUserIDArray = ["1", "2", "3"]
            
            inviteArray.append(invite)
        }
    }
    
    class func getInvites() {
        let params: [String: AnyObject] = [
            "name": "hoge"
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/api/v1/restaurants/search", parameters: params, encoding: .JSON).responseJSON { (any) -> Void in
            print(any)
        }
    }
    
    class func postInvite(text: String, restaurantID: Int, pressTime: String) {
        let params: [String: AnyObject] = [
            "text": text,
            "restaurant_id": restaurantID,
            "press_time": pressTime
        ]
        
        let URL = NSURL(string: "http://localhost:3000/api/v1/invites/create")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        let request = Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        manager.request(request).responseJSON { (any) in
            print(any)
        }

    }

}
