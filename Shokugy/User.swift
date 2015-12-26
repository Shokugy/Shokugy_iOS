//
//  User.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/28.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

class User: NSObject {
    static let currentUser = User()
    
    var id: Int?
    var name: String?
    var avatar: UIImage?
    var userFBID: String?

    class func getUser() {
        
    }
    
    class func setUser(id: Int, name: String,userFBID: String) {
        let profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://graph.facebook.com/\(userFBID)/picture?type=large")!)!)

        currentUser.id = id
        currentUser.name = name
        currentUser.avatar = profileImage
        currentUser.userFBID = userFBID
    }
    
    class func fetchUserFromFB() {
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,gender,link,locale,name,timezone,updated_time,verified,last_name,first_name,middle_name"], HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            
            guard error == nil else {
                print(error)
                print("where: fetchUserFromFB User.swift")
                return
            }
            
            let userName = result["name"] as! String
            let userFBID = result["id"] as! String
            
            createUser(userName, userFBID: userFBID)
        })
        
    }
    
    class func createUser(name: String, userFBID: String) {
        let params: [String: AnyObject] = [
            "name": name,
            "fb_id": userFBID
        ]
        Alamofire.request(.POST, "http://localhost:3000/api/v1/users/create", parameters: params, encoding: .JSON).responseString { (any) -> Void in
            let json = JSON(data: any.data!)
            let userID = json["userId"].int
            
            setUser(userID!,name: name, userFBID: userFBID)
            saveDataForDevice()
        }
    }
    
    class func saveDataForDevice() {
        let avatarData = UIImagePNGRepresentation(currentUser.avatar!)
        let userDic: [String: AnyObject] = ["id": currentUser.id!, "name": currentUser.name!, "avatar": avatarData!, "fbID": currentUser.userFBID!]
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(userDic, forKey: "user")
        ud.synchronize()
    }
    
    class func fetchDataFromDeviceSetUser() -> Bool {
        let ud = NSUserDefaults.standardUserDefaults()
        
        guard ud.objectForKey("user") != nil else {
            print("fetch error")
            return false
        }
        
        let userDic = ud.objectForKey("user")
        currentUser.id = userDic!["id"] as? Int
        currentUser.name = userDic!["name"] as? String
        let avatarImage = userDic!["avatar"] as? NSData
        currentUser.avatar = UIImage(data: avatarImage!)
        currentUser.userFBID = userDic!["fbID"] as? String
        
        print("fetch success(user default)")
        
        return true
    }
    
    class func getUserWithFBID(fbID: String, callback: (JSON) -> Void) {
        let URL = NSURL(string: "http://localhost:3000/api/v1/users/mypage")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        mutableURLRequest.setValue(fbID, forHTTPHeaderField: "Fb-Id")
        let manager = Alamofire.Manager.sharedInstance
        
        manager.request(mutableURLRequest).responseJSON { (any) -> Void in
            print("=============================")
            print(JSON(data: any.data!))
            let json = JSON(data: any.data!)
            print(any.result)
            callback(json)
            print("=============================")
        }

    }
    
}
