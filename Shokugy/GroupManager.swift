//
//  GroupManager.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/24.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GroupManager: NSObject {

    class func createGroup(name: String, password: String, passwordConf: String) {
        let params: [String: AnyObject] = [
            "name": name,
            "password": password,
            "password_confirmation": passwordConf
        ]
        
        let URL = NSURL(string: "http://localhost:3000/api/v1/groups/create")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        let request = Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        manager.request(request).responseJSON { (any) in
            print(any)
        }
//        Alamofire.request(.POST, "http://localhost:3000/api/v1/groups/create", parameters: params, encoding: .JSON).responseJSON { (any) -> Void in
//            print(any)
//        }
    }
}
