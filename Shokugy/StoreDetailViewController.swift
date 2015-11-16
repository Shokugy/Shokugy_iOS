
import UIKit

class StoreDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {

    @IBOutlet weak var commentTableView: UITableView!
    let postViewController = UIViewController()
    let placeholderLabel = UILabel()
    let postTextView = UITextView()


    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        commentTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        commentTableView.dataSource = self
        commentTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "postIcon.png"), style: .Plain, target: self, action: "tapPostBtn")
    }
    
    @IBAction func tapTaberoguBtn(sender: UIButton) {
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCellWithIdentifier("customCell") as! CommentTableViewCell
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 0.1
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.width/2
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
        
    }
    
    func tapPostBtn() {
        self.presentViewController(setPostViewController(), animated: true, completion: nil)
    }
    
    //------------postViweControllerSetting------------------------
    
    func setPostViewController() -> UIViewController {
        let navController = UINavigationController()
        navController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        navController.navigationBar.translucent = false
        addGesture(navController.view)
        
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
        storeNameLabel.textColor = UIColor.whiteColor()
        storeNameLabel.frame = CGRectMake(0, 0, self.view.frame.width, 100)
        storeNameLabel.backgroundColor = UIColor(red: 1, green: 153/255, blue: 51/255, alpha: 1)
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

}
