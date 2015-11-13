//
//  HomeTableViewCell.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/13.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var profImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeAccess: UILabel!
    @IBOutlet weak var userComment: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var numOfLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profImageView.layer.cornerRadius = profImageView.frame.width/2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
