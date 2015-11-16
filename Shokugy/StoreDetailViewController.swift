
import UIKit

class StoreDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var commentTableView: UITableView!
    let postViewController = UIViewController()

    
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
    
    func setPostViewController() -> UIViewController {
        let navController = UINavigationController()
        navController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        navController.navigationBar.translucent = false
        
        postViewController.view.frame = view.frame
        postViewController.view.backgroundColor = UIColor.whiteColor()
        navController.setViewControllers([postViewController], animated: true)
        postViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "batu.png"), style: .Plain, target: self, action: "tapCloseBtn")
        postViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: "postViewPostBtn")
        postViewController.navigationItem.title = "口コミ投稿"
        return navController
    }
    
    func tapCloseBtn() {
        postViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postViewPostBtn() {
        print("posted")
        postViewController.dismissViewControllerAnimated(true, completion: nil)
    }


}
