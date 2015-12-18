//
//  CommentTableViewCell.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/15.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userReviewLabel: UILabel!
    @IBOutlet weak var numOfGoodLabel: UILabel!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.clipsToBounds = true
        
        let image = UIImage(named: "like.png")?.imageWithRenderingMode(.AlwaysTemplate)
        likeButton.setImage(image, forState: .Normal)
        likeButton.imageView?.tintColor = UIColor.grayColor()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tapLikeButton(sender: UIButton) {
        sender.imageView?.tintColor = UIColor.redColor()
    }
    
}
