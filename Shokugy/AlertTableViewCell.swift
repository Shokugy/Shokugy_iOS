//
//  AlertTableViewCell.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/13.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {

    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertDetail: UILabel!
    @IBOutlet weak var alertTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
