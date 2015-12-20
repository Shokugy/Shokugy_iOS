//
//  CommentCollection.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/20.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class CommentCollection: NSObject {
    var commentArray: [Comment] = []
    
    func getComment() {
        for _ in 1...10 {
            let comment = Comment()
            
            comment.userID = 1
            comment.rate = 4
            comment.comment = "さいこうまじさいこう"
            comment.numOfLike = 2
            comment.postTime = "2015/12/24"
            
            commentArray.append(comment)
        }
    }
}
