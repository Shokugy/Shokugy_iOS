protocol HomeTableViewCellDelegate {
    func tapFavBtn(sender: UIButton)
    func tapShowMemberBtn()
}

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var customDelegate: HomeTableViewCellDelegate?

    @IBOutlet weak var profImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeAccess: UILabel!
    @IBOutlet weak var userComment: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var numOfLike: UILabel!
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var showMemberBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profImageView.layer.cornerRadius = profImageView.frame.width/2
        profImageView.clipsToBounds = true
        
        setImageColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImageColor() {
        var memberImage = UIImage(named: "+member.png")?.imageWithRenderingMode(.AlwaysTemplate)
        plusBtn.setImage(memberImage, forState: .Normal)
        plusBtn.imageView?.tintColor = UIColor(red: 240/255, green: 168/255, blue: 43/255, alpha: 1)
        memberImage = UIImage(named: "-member.png")?.imageWithRenderingMode(.AlwaysTemplate)
        plusBtn.setImage(memberImage, forState: .Selected)
        
        let showMemberImage = UIImage(named: "showMember.png")?.imageWithRenderingMode(.AlwaysTemplate)
        showMemberBtn.setImage(showMemberImage, forState: .Normal)
        showMemberBtn.tintColor = UIColor(red: 240/255, green: 168/255, blue: 43/255, alpha: 1) 
        
    }
    
    var counter = 1
    @IBAction func tapFavBtn(sender: UIButton) {
        if counter % 2 != 0 {
            sender.selected = true
            customDelegate?.tapFavBtn(sender)
        } else {
            sender.selected = false
        }
        counter += 1
    }
    
    @IBAction func tapMemberDetailBtn(sender: UIButton) {
        customDelegate?.tapShowMemberBtn()
    }
}
