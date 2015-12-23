//
//  UINavigationItem+Extension.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/23.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    
    func setMyTitle(title: String) {
        let labelView = UILabel()
        labelView.frame.size = CGSize(width: 30, height: 30)
        labelView.text = title
        labelView.font = UIFont.systemFontOfSize(25)
        labelView.textColor = UIColor.whiteColor()
        self.titleView = labelView
    }
    
}