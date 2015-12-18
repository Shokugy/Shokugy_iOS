
import UIKit

class StoreDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    let postViewController = UIViewController()
    let placeholderLabel = UILabel()
    let postTextView = UITextView()
    let commentTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "postIcon.png"), style: .Plain, target: self, action: "tapPostBtn")
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func setUp() {
        let coverView = UIView()
        coverView.backgroundColor = UIColor(red: 252/255, green: 166/255, blue: 51/255, alpha: 1)
        coverView.frame.size = CGSizeMake(self.view.frame.width, 170)
        coverView.frame.origin = CGPointMake(0, 0)
        self.view.addSubview(coverView)
        
        let storeNameLabel = UILabel()
        storeNameLabel.text = "すき家　茶屋町店"
        storeNameLabel.textColor = UIColor.whiteColor()
        storeNameLabel.font = UIFont(name: (storeNameLabel.font?.fontName)!, size: 27)
        storeNameLabel.sizeToFit()
        storeNameLabel.frame.origin = CGPointMake(10, 16)
        coverView.addSubview(storeNameLabel)
        
        let rateImageView = UIImageView(image: UIImage(named: "rate4"))
        rateImageView.clipsToBounds = true
        rateImageView.frame.size = CGSizeMake(self.view.frame.width/2, 40)
        rateImageView.frame.origin.x = storeNameLabel.frame.origin.x - 2
        rateImageView.frame.origin.y = storeNameLabel.frame.origin.y + storeNameLabel.frame.height + 16
        coverView.addSubview(rateImageView)
        
        let inviteBtn = UIButton()
        let inviteImage = UIImage(named: "invite")?.imageWithRenderingMode(.AlwaysTemplate)
        inviteBtn.imageView?.tintColor = UIColor.whiteColor()
        inviteBtn.setImage(inviteImage, forState: .Normal)
        inviteBtn.setTitle("Invite!", forState: .Normal)
        inviteBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        inviteBtn.titleLabel
        inviteBtn.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        inviteBtn.sizeToFit()
        inviteBtn.frame.origin.x = storeNameLabel.frame.origin.x - 2
        inviteBtn.frame.origin.y = rateImageView.frame.origin.y + rateImageView.frame.height + 16
        inviteBtn.addTarget(self, action: "tapInviteBtn", forControlEvents: .TouchUpInside)
        coverView.addSubview(inviteBtn)
        
        let taberoguBtn = UIButton()
        taberoguBtn.setTitle("ぐるなびへ", forState: .Normal)
        taberoguBtn.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        taberoguBtn.sizeToFit()
        taberoguBtn.frame.origin.y = inviteBtn.frame.origin.y + 7
        taberoguBtn.frame.origin.x = self.view.frame.width - taberoguBtn.frame.width - 26
        taberoguBtn.addTarget(self, action: "tapTaberoguBtn", forControlEvents: .TouchUpInside)
        coverView.addSubview(taberoguBtn)
        
        commentTableView.frame.size = CGSizeMake(self.view.frame.width, self.view.frame.height - coverView.frame.height - 64 - 49)
        commentTableView.frame.origin = CGPointMake(0, coverView.frame.height)
        commentTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        commentTableView.dataSource = self
        commentTableView.delegate = self
        self.view.addSubview(commentTableView)
        
        self.commentTableView.colorBackground(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
    }
    
    func tapPostBtn() {
        self.presentViewController(setPostViewController(), animated: true, completion: nil)
    }
    
    func tapInviteBtn() {
        let coverView = setInviteView()
        UIView.animateWithDuration(0.3) { () -> Void in
            coverView.frame.origin = CGPointMake(0, 0)
        }
    }
    
    func tapTaberoguBtn() {
        print("tapTaberogu")
    }
    
    //---------TableViewSetting-------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCellWithIdentifier("customCell") as! CommentTableViewCell
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 0.1
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.width/2
        
        cell.rateImageView.image = UIImage(named: "rate4")
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 6
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 10 {
            return 6
        } else {
            return 3
        }
    }
    
    
    //------------postViweControllerSetting------------------------
    
    func setPostViewController() -> UIViewController {
        let navController = UINavigationController()
        navController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        navController.navigationBar.tintColor = UIColor.whiteColor()
        navController.navigationBar.translucent = false
        addGesture(navController.view)
        navController.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        postViewController.view.frame = view.frame
        postViewController.view.backgroundColor = UIColor.whiteColor()
        navController.setViewControllers([postViewController], animated: true)
        postViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "batu.png"), style: .Plain, target: self, action: "tapCloseBtn")
        postViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: "postViewPostBtn")
        postViewController.navigationItem.title = "口コミ投稿"
        postViewController.view.addSubview(setPostViewStoreNameLabel())
        postViewController.view.addSubview(setPostViewStoreRateview())
        postViewController.view.addSubview(setPostViewTextView())
        addGesture(postViewController.view)
        
        return navController
    }
    
    func tapCloseBtn() {
        postViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postViewPostBtn() {
        print("posted")
        postViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setPostViewStoreNameLabel() -> UILabel {
        let storeNameLabel = UILabel()
        storeNameLabel.text = "すき家　茶屋町店"
        storeNameLabel.font = UIFont.systemFontOfSize(30)
        storeNameLabel.textColor = UIColor.whiteColor()
        storeNameLabel.frame = CGRectMake(0, 0, self.view.frame.width, 100)
        storeNameLabel.backgroundColor = UIColor(red: 252/255, green: 166/255, blue: 51/255, alpha: 1)
        addGesture(storeNameLabel)
        
        return storeNameLabel
    }
    
    func setPostViewStoreRateview() -> UIView {
        let view = UIView()
        view.frame = CGRectMake(0, 100, self.view.frame.width, 80)
        let imageView = UIImageView()
        
        view.backgroundColor = UIColor.redColor()
        view.addSubview(imageView)
        addGesture(view)
        
        return view
    }

    func setPostViewTextView() -> UITextView {
        postTextView.frame = CGRectMake(5, 190, self.view.frame.width-10, 200)
        postTextView.layer.borderWidth = 1
        postTextView.layer.cornerRadius = 10
        postTextView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        
        placeholderLabel.frame.origin = CGPointMake(10, 10)
        placeholderLabel.text = "本文を入力してください"
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        postTextView.addSubview(placeholderLabel)
        
        postTextView.delegate = self
        
        return postTextView
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        placeholderLabel.hidden = true
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if postTextView.text.isEmpty {
            placeholderLabel.hidden = false
        }
    }
    
    func addGesture(view: UIView) {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: "tapWhenEditTextView")
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    func tapWhenEditTextView() {
        postTextView.resignFirstResponder()
    }
    
    //------------------invite view------------------------------------
    
    let coverView = UIView()
    let textField = UITextField()

    func setInviteView() -> UIView {
        coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        coverView.frame.size = self.view.frame.size
        coverView.frame.origin = CGPointMake(0, self.view.frame.height)
        self.view.addSubview(coverView)
        
        let inviteView = UIView()
        inviteView.frame.size = CGSizeMake(300, 180)
        inviteView.center = CGPointMake(self.view.center.x, self.view.center.y-61)
        inviteView.backgroundColor = UIColor(red: 252 / 255, green: 166 / 255, blue: 51 / 255, alpha: 1)
        inviteView.layer.cornerRadius = 10
        coverView.addSubview(inviteView)
        
        inviteView.addSubview(setInviteViewTextField(inviteView))
        inviteView.addSubview(setInviteViewStoreNameLabel(inviteView, text: "すき家"))
        
        inviteView.addSubview(setInviteViewBtn("Cancel", x: inviteView.frame.width / 4 - 25, superView: inviteView, tag: 1))
        inviteView.addSubview(setInviteViewBtn("Invite", x: inviteView.frame.width / 4 * 2 - 20, superView: inviteView, tag: 2))
        inviteView.addSubview(setInviteViewAddMember(inviteView))
        
        return coverView
    }
    
    func setInviteViewStoreNameLabel(superView: UIView, text: String) -> UILabel {
        let label = UILabel()
        label.frame.size = CGSizeMake(superView.frame.width, 50)
        label.frame.origin = CGPointMake(17, 10)
        label.text = text
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(25)
        
        return label
    }
    
    func setInviteViewTextField(superView: UIView) -> UITextField {
        textField.frame.size = CGSizeMake(superView.frame.width-35, 35)
        textField.center = CGPointMake(superView.center.x-superView.frame.origin.x, 75)
        textField.placeholder = "ひとこと"
        textField.layer.borderWidth = 0.1
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.whiteColor()
        textField.delegate = self
        return textField
    }

    func setInviteViewAddMember(superView: UIView) -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "+member")?.imageWithRenderingMode(.AlwaysTemplate)
        button.setImage(image, forState: .Normal)
        button.imageView?.tintColor = UIColor.whiteColor()
        button.frame.size = CGSizeMake(44, 44)
        button.center = CGPointMake(superView.frame.width/5 - 25, 120)
        button.addTarget(self, action: "tapAddMember", forControlEvents: .TouchUpInside)
        return button
    }
    
    func setInviteViewBtn(text: String, x: CGFloat, superView: UIView, tag: Int) -> UIButton{
        let button = UIButton()
        button.setTitle(text, forState: .Normal)
        button.setTitleColor(UIColor(red: 252/255, green: 221/255, blue: 0/255, alpha: 1), forState: .Highlighted)
        button.frame.size = CGSizeMake(60, 30)
        button.center = CGPointMake(x, 150)
        button.tag = tag
        button.addTarget(self, action: "tapInviteViewBtn:", forControlEvents: .TouchUpInside)
        
        return button
    }
    
    func tapInviteViewBtn(sender: UIButton) {
        switch sender.tag {
        case 1:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.coverView.frame.origin = CGPointMake(0, self.view.frame.height)
            }, completion: { (finished) -> Void in
                self.coverView.removeFromSuperview()
            })
        case 2:
            print("post")
        default:
            break
        }
    }
    
    func tapAddMember() {
        let hoge = AddMemberTableViewController()
        self.navigationController?.pushViewController(hoge, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setAdddMemberTableViewControllerWithNav() {
        let navController = UINavigationController(rootViewController: (self.navigationController)!)
        
        let addMemberTableViewController = AddMemberTableViewController()
        navController.setViewControllers([addMemberTableViewController], animated: true)
        self.presentViewController(navController, animated: true, completion: nil)
    }

}
