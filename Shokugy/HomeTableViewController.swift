extension UINavigationItem {
    
    func setMyTitle(title: String) {
        let labelView = UILabel()
        labelView.frame.size = CGSize(width: 30, height: 30)
        labelView.text = title
        labelView.font = UIFont.systemFontOfSize(25)
        labelView.textColor = UIColor.whiteColor()
        self.titleView = labelView
    }
    
}

extension UITableView {
    func colorBackground(color: UIColor) {
        let view = UIView(frame: self.frame)
        view.backgroundColor = color
        self.backgroundView = view
    }
}

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeTableViewController: UITableViewController, HomeTableViewCellDelegate, FBSDKLoginButtonDelegate {
    
    let sampleData = ["soya", "yuya", "kotasawadaIndy"]
    var sampleFav = [1,2,0]
    
    let viewController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
       
        self.tableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }
    
    //----------------------fbsdk---------------------------------------------------------
    
    func setFBLogin() {
        if FBSDKAccessToken.currentAccessToken() != nil {
            print("loginned")
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
        if (error != nil)
        {
            //エラー処理
//        } else if result.isCancelled {
            //キャンセルされた時

        } else {
            //必要な情報が取れていることを確認(今回はemail必須)
//            if result.grantedPermissions.contains("email")
//            {
                // 次の画面に遷移（後で）
//                returnUserData()

            }
//        }
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func returnUserData() {
//        
//        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,gender,link,locale,name,timezone,updated_time,verified,last_name,first_name,middle_name"], HTTPMethod: "GET")
//        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
//            if(error == nil)
//            {
//                print("result \(result)")
//            }
//            else
//            {
//                print("error \(error)")
//            }
//        })
//        
//    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    }
    
    //------------------------------fbsdk end----------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setFBLogin()
        setNavBar()
    }
    
    func setNavBar() {
        let rightBarBtn = UIBarButtonItem(image:UIImage(named: "invite"), style: .Plain, target: self, action: "tapRightBarBtn")
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.setMyTitle("Shokugy")
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 6
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == (sampleData.count - 1) {
            return 6
        } else {
            return 3
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sampleData.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell") as! HomeTableViewCell
        cell.customDelegate = self
        
        cell.userName.text = sampleData[indexPath.row]
        cell.numOfLike.text = "\(sampleFav[indexPath.row])"
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 2
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        //テキストフィールドの行数に合わせてセルの大きさを変える
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94
    }
    
    func tapRightBarBtn() {
        self.performSegueWithIdentifier("ToSearchViewController", sender: self)
    }
    
    func tapFavBtn(sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! HomeTableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        sampleFav[(indexPath?.row)!] += 1
        cell.numOfLike.text = "\(sampleFav[(indexPath?.row)!])"
    }
    
    func tapShowMemberBtn() {
        let goingMemberViewController = GoingMenberViewController()
        self.navigationController?.pushViewController(goingMemberViewController, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGoingMenberViewController" {
            let goingMenberViewController = segue.destinationViewController as! GoingMenberViewController
            goingMenberViewController.storeName = "すき家　茶屋町店"
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storeDetailViewController = StoreDetailViewController()
        self.navigationController?.pushViewController(storeDetailViewController, animated: true)
    }

    

}
