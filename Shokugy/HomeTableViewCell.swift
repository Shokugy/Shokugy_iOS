protocol HomeTableViewCellDelegate {
    func tapFavBtn()
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
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapFavBtn(sender: UIButton) {
        customDelegate?.tapFavBtn()
    }
    
    @IBAction func tapNomOfFavBtn(sender: UIButton) {
        customDelegate?.tapNumOfFavBtn()
    }
    
    @IBAction func tapStoreNameBtn(sender: UIButton) {
        customDelegate?.tapStoreNameBtn()
    }
}
