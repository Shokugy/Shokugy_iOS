//
//  User.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/28.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class User: NSObject {
    static let sharedInstance = User()
    
    var name: String?
    var avatar: UIImage?
    var userFBID: String?

    
    class func setUser(name: String, avatar: UIImage, userFBID: String) {
        sharedInstance.name = name
        sharedInstance.avatar = avatar
        sharedInstance.userFBID = userFBID
    }
    
    class func fetchUserFromFB() {
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,gender,link,locale,name,timezone,updated_time,verified,last_name,first_name,middle_name"], HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            
            guard error == nil else {
                print(error)
                return
            }
            
            print("result \(result)")
            let userID = result["id"] as! String
            let profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://graph.facebook.com/\(userID)/picture?type=large")!)!)
            setUser(result["name"] as! String, avatar: profileImage!, userFBID: userID)
            
            saveDataForDevice()
            
        })
        
    }
    
    class func saveDataForDevice() {
        let avatarData = UIImagePNGRepresentation(sharedInstance.avatar!)
        let userDic: [String: AnyObject] = ["name": sharedInstance.name!, "avatar": avatarData!, "fbID": sharedInstance.userFBID!]
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(userDic, forKey: "user")
        ud.synchronize()
    }
    
    class func fetchDataFromDevice() -> Bool {
        let ud = NSUserDefaults.standardUserDefaults()
        let userDic = ud.objectForKey("user")
        
        guard let _ = ud.objectForKey("user") else {
            print("fetch error")
            return false
        }
        sharedInstance.name = userDic!["name"] as? String
        let avatarImage = userDic!["avatar"] as? NSData
        sharedInstance.avatar = UIImage(data: avatarImage!)
        sharedInstance.userFBID = userDic!["fbID"] as? String
        
        return true
    }
    
}
