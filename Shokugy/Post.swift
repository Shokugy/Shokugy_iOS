//
//  Post.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/20.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class Post: NSObject {
    var storeName: String?
    var access: String?
    var comment: String?
    var postTime: String?
    var userID: Int?
    var goingMemberUserIDArray: [Int] = []
}
