
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
        invite.storeName = json["restaurantName"].string
        invite.access = json["restaurantAddress"].string
        invite.comment = json["text"].string
        invite.postTime = json["date"].string
        invite.userID = json["userFbId"].string
        invite.userName = json["userName"].string
        invite.restaurantID = json["restaurantId"].int
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
        
//        let scrollView = UIScrollView()
//        scrollView.frame = setUpViewController.view.frame
//        scrollView.contentSize = CGSize(width: scrollView.frame.width * 2, height: scrollView.frame.height)
//        scrollView.backgroundColor = UIColor.clearColor()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile","email"] //これかかないとemailとれない
        loginButton.delegate = self
        setUpViewController.view.addSubview(loginButton)
        
//        let groupViewController = GroupViewController(isFirst: true)
//        groupViewController.receiveIsFirst = true
//        let groupView = groupViewController.view
//        groupView.frame.origin = CGPoint(x: scrollView.frame.width, y: 0)
//        scrollView.addSubview(groupView)
        
//        setUpViewController.view.addSubview(scrollView)
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
        print("=")
        print(inviteArray[(indexPath?.section)!].goingMemberUserIDArray)
        inviteArray[(indexPath?.section)!].goingMemberUserIDArray.append(User.currentUser.userFBID!)
        print(inviteArray[(indexPath?.section)!].goingMemberUserIDArray)
        print("=")
        self.tableView.reloadData()
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
        cell.userName.text = "hoge"
//        cell.profImageView.image 
        cell.storeName.text = invite.storeName
        cell.storeAccess.text = invite.access
        cell.userComment.text = invite.comment
        cell.postTime.text = invite.postTime
        print(invite.goingMemberUserIDArray)
        cell.numOfLike.text = "\(invite.goingMemberUserIDArray.count)"
        print(invite.goingMemberUserIDArray.count)
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
