
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeTableViewController: UITableViewController, HomeTableViewCellDelegate, FBSDKLoginButtonDelegate {
    
    let sampleData = ["soya", "yuya", "kotasawadaIndy"]
    var sampleFav = [1,2,0]
    let inviteCollection: InviteCollection = InviteCollection()
    var sendInvite: Invite = Invite()
    
    let viewController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
        
        inviteCollection.getInvites()
    }
    
    //----------------------fbsdk---------------------------------------------------------
    
    func setFBLogin() {
        if FBSDKAccessToken.currentAccessToken() != nil {
            print("loginned")
            User.fetchDataFromDeviceSetUser()
        } else {
            //-------FBLoginView----------
            viewController.view.backgroundColor = UIColor(red: 252/255, green: 166/255, blue: 51/255, alpha: 1)
            let loginButton = FBSDKLoginButton()
            loginButton.center = self.view.center
            loginButton.readPermissions = ["public_profile","email"] //これかかないとemailとれない
            loginButton.delegate = self
            viewController.view.addSubview(loginButton)
            
            self.presentViewController(viewController, animated: true, completion: nil)
            //---------------------------
            
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        guard error == nil else {
            print(error)
            return
        }
        
        User.fetchUserFromFB()
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    }
    
    //------------------------------fbsdk end----------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        setFBLogin()
        
//        print(User.currentUser.id, User.currentUser.name, User.currentUser.userFBID)
    }
    
    func setNavBar() {
        let rightBarBtn = UIBarButtonItem(image:UIImage(named: "invite"), style: .Plain, target: self, action: "tapRightBarBtn")
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.setMyTitle("Shokugy")
    }
    
    func tapRightBarBtn() {
        self.performSegueWithIdentifier("ToSearchViewController", sender: self)
    }
    
    func tapFavBtn(sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! HomeTableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        inviteCollection.inviteArray[(indexPath?.section)!].goingMemberUserIDArray.append(User.currentUser.userFBID!)
        self.tableView.reloadData()
    }
    
    func tapShowMemberBtn() {
        let goingMemberViewController = GoingMenberViewController()
        self.navigationController?.pushViewController(goingMemberViewController, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGoingMenberViewController" {
            let goingMenberViewController = segue.destinationViewController as! GoingMenberViewController
            goingMenberViewController.storeName = "すき家　茶屋町店"
        } else if segue.identifier == "SegueToStoreDetailViewController" {
            let storeDetailViewController = segue.destinationViewController as! StoreDetailViewController
            storeDetailViewController.receiveInvite = sendInvite
        }
    }
    
    //--------------TableViewSetting---------------------------------------------------
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sendInvite = inviteCollection.inviteArray[indexPath.section]
        self.performSegueWithIdentifier("SegueToStoreDetailViewController", sender: self)
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return inviteCollection.inviteArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell") as! HomeTableViewCell
        cell.customDelegate = self
        
    
        let invite = inviteCollection.inviteArray[indexPath.section]
        cell.userName.text = sampleData[indexPath.row]
//        cell.profImageView.image 
        cell.storeName.text = invite.storeName
        cell.storeAccess.text = invite.access
        cell.userComment.text = invite.comment
        cell.postTime.text = invite.postTime
        cell.numOfLike.text = "\(invite.goingMemberUserIDArray.count)"
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        //------ユーザーの投稿ならボタン押せない  投稿昨日のあとにテスト-----------
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if invite.userID == User.currentUser.userFBID {
            cell.plusBtn.enabled = false
        }
        //-------------------------------------------------
        
        //テキストフィールドの行数に合わせてセルの大きさを変える
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 6
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == (inviteCollection.inviteArray.count) {
            return 6
        } else {
            return 3
        }
    }

}
