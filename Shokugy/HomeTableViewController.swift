
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON

class HomeTableViewController: UITableViewController, HomeTableViewCellDelegate, FBSDKLoginButtonDelegate {
    
    var sendInvite: Invite = Invite()
    var inviteArray: [Invite] = []
    
    let setUpViewController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }
    
    //----------------------fbsdk---------------------------------------------------------
    
    func setFBLogin() {
        if FBSDKAccessToken.currentAccessToken() != nil {
            print("loginned")
            User.fetchDataFromDeviceSetUser()
            InviteCollection.getInvites({ (json) -> Void in
                self.inviteArray = []
                for i in 0 ..< json.count {
                    self.makeInviteAndSet(json[i])
                }
                self.tableView.reloadData()
            })
        } else {
            //-------FBLoginView----------
            setSetUpViewController()
            self.presentViewController(setUpViewController, animated: true, completion: nil)
            //---------------------------
//            RestaurantManager.fetchRestaurant(1)

            
        }
    }
    
    //-----test用-------
    var counter = 0
    //---------------
    
    func makeInviteAndSet(json: JSON) {
        let invite = Invite()
        invite.id = json["id"].int
        invite.storeName = json["restaurantName"].string
        invite.access = json["restaurantAddress"].string
        invite.comment = json["text"].string
        invite.postTime = json["date"].string
        invite.userID = json["userFbId"].string
        invite.userName = json["userName"].string
        invite.restaurantID = json["restaurantId"].int
        let profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://graph.facebook.com/\(invite.userID!)/picture?type=large")!)!)
        invite.userAvatar = profileImage
//        invite.goingMemberUserIDArray.append(invite.userID!)
        
        //------test用
        if counter % 2 == 0 {
            invite.userID = "612751962169561"
        }
        invite.goingMemberUserIDArray.append(invite.userID!)
        counter += 1
        //-------
        
        inviteArray.append(invite)
    }
    
    func setSetUpViewController() {
        setUpViewController.view.backgroundColor = UIColor(red: 252/255, green: 166/255, blue: 51/255, alpha: 1)
        let backgroundImage = UIImage(named: "shokugy")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height + 64 + 49)
        backgroundImageView.frame.origin = CGPointZero
        backgroundImageView.userInteractionEnabled = true
        setUpViewController.view.addSubview(backgroundImageView)
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile","email"] //これかかないとemailとれない
        loginButton.delegate = self
        backgroundImageView.addSubview(loginButton)
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        guard error == nil else {
            print(error)
            return
        }
        
        User.fetchUserFromFB()
        setUpViewController.dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("ToGroupViewController", sender: nil)
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
        inviteArray[(indexPath?.section)!].goingMemberUserIDArray.append(User.currentUser.userFBID!)
        self.tableView.reloadData()
        InviteCollection.postJoinMember(inviteArray[(indexPath?.section)!].id!)
    }
    
    func tapFavMinusBtn(sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! HomeTableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        var goingMemberUserIDArray = inviteArray[(indexPath?.section)!].goingMemberUserIDArray
        for i in 0 ..< goingMemberUserIDArray.count {
            if goingMemberUserIDArray[i] == User.currentUser.userFBID! {
                goingMemberUserIDArray.removeAtIndex(i)

                inviteArray[(indexPath?.section)!].goingMemberUserIDArray = goingMemberUserIDArray
                self.tableView.reloadData()
            }
        }
    }
    
    func tapShowMemberBtn(sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! HomeTableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        sendInvite = inviteArray[indexPath!.section]
        
        self.performSegueWithIdentifier("ToGoingMemberViewController", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToGoingMemberViewController" {
            let goingMenberViewController = segue.destinationViewController as! GoingMenberViewController
            goingMenberViewController.receiveStoreName = sendInvite.storeName
            goingMenberViewController.receiveGoingMemberArray = sendInvite.goingMemberUserIDArray
        } else if segue.identifier == "SegueToStoreDetailViewController" {
            let storeDetailViewController = segue.destinationViewController as! StoreDetailViewController
            storeDetailViewController.receiveInvite = sendInvite
        }
    }
    
    //--------------TableViewSetting---------------------------------------------------
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sendInvite = inviteArray[indexPath.section]
        self.performSegueWithIdentifier("SegueToStoreDetailViewController", sender: self)
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return inviteArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell") as! HomeTableViewCell
        cell.customDelegate = self
        
    
        let invite = inviteArray[indexPath.section]
        cell.userName.text = invite.userName
        cell.profImageView.image = invite.userAvatar
        cell.storeName.text = invite.storeName
        cell.storeAccess.text = invite.access
        cell.userComment.text = invite.comment
        cell.postTime.text = invite.postTime
        cell.numOfLike.text = "\(invite.goingMemberUserIDArray.count)"
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        //------ユーザーの投稿ならボタン押せない  投稿昨日のあとにテスト-----------
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        if invite.userID! == User.currentUser.userFBID! {
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
        if section == inviteArray.count {
            return 6
        } else {
            return 3
        }
    }

}
