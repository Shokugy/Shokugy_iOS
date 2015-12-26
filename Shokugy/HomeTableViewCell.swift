protocol HomeTableViewCellDelegate {
    func tapFavBtn(sender: UIButton)
    func tapFavMinusBtn(sender: UIButton)
    func tapShowMemberBtn(sender: UIButton)
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
    
    var isSelect: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profImageView.layer.cornerRadius = profImageView.frame.width/2
        profImageView.clipsToBounds = true
        
        setImageColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    
    @IBAction func tapFavBtn(sender: UIButton) {
        if !isSelect {
            sender.selected = true
            customDelegate?.tapFavBtn(sender)
            isSelect = true
        } else {
            sender.selected = false
            customDelegate?.tapFavMinusBtn(sender)
            isSelect = false
        }
    }
    
    @IBAction func tapMemberDetailBtn(sender: UIButton) {
        customDelegate?.tapShowMemberBtn(sender)
    }
}
