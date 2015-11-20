//
//  RankingTableViewCell.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/20.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var rankingNumLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeAccessLabel: UILabel!
    @IBOutlet weak var rateImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
