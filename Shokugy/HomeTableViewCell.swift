protocol HomeTableViewCellDelegate {
    func tapFavBtn(sender: UIButton)
    func tapNumOfFavBtn()
    func tapStoreNameBtn()
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profImageView.layer.cornerRadius = profImageView.frame.width/2
        profImageView.clipsToBounds = true
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    @IBAction func tapNomOfFavBtn(sender: UIButton) {
        customDelegate?.tapNumOfFavBtn()
    }
    
    @IBAction func tapStoreNameBtn(sender: UIButton) {
        customDelegate?.tapStoreNameBtn()
    }
    @IBAction func tapMemberDetailBtn(sender: UIButton) {
    }
}
