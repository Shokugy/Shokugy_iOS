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
    static var groups: [Group] = []

    class func createGroup(name: String, password: String, passwordConf: String, callback: () -> Void) {
        let params: [String: AnyObject] = [
            "name": name,
            "password": password,
            "password_confirmation": passwordConf
        ]
        
        let URL = NSURL(string: "http://localhost:3000/api/v1/groups/create")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        mutableURLRequest.setValue(password, forHTTPHeaderField: "Passwd")
//        mutableURLRequest.setValue(passwordConf, forHTTPHeaderField: "Password-Confirmation")
        let manager = Alamofire.Manager.sharedInstance
        let request = Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        manager.request(request).responseJSON { (any) in
            print(any)
            callback()
        }
        
    }
    
    class func getGroup(callback: (JSON) -> Void) {
        let URL = NSURL(string: "http://localhost:3000/api/v1/groups")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            let json = JSON(data: any.data!)["groups"]
            callback(json)
        }
    }
    
    class func loginGroup(name: String, password: String) {
        let params: [String: AnyObject] = [
            "name": name,
        ]
        
        let URL = NSURL(string: "http://localhost:3000/api/v1/groups/login")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue(User.currentUser.userFBID!, forHTTPHeaderField: "Fb-Id")
        mutableURLRequest.setValue(password, forHTTPHeaderField: "Passwd")
        let manager = Alamofire.Manager.sharedInstance
        let request = Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        manager.request(request).responseJSON { (any) in
            print(JSON(data: any.data!))
            print("------")
            print(any.result)
//            callback()
        }

    }
}
