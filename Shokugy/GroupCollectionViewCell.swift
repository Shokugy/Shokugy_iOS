//
//  GroupCollectionViewCell.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/24.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {

    let label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        label.text = "h"
        label.frame = self.frame
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
    }

}
