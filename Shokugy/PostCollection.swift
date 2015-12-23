//
//  PostCollection.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/20.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import Alamofire

class PostCollection: NSObject {
    static let sharedInstance = PostCollection()
    
    var postArray: [Post] = []
    
    func getPosts() {
        for _ in 1...10 {
            let post = Post()
            post.storeName = "すきや"
            post.access = "大阪市北区"
            post.comment = "いきましょー"
            post.postTime = "5分前"
            post.userID = "1"
            post.restaurantID = 1
            post.goingMemberUserIDArray = [1, 2, 3]
            
            postArray.append(post)
        }
    }
    
    class func getPosts() {
        let params: [String: AnyObject] = [
            "name": "hoge"
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/api/v1/restaurants/search", parameters: params, encoding: .JSON).responseJSON { (any) -> Void in
            print(any)
        }

    }
    
    
    
}
