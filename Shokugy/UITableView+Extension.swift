//
//  UITableView+Extension.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/23.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func colorBackground(color: UIColor) {
        let view = UIView(frame: self.frame)
        view.backgroundColor = color
        self.backgroundView = view
    }
}