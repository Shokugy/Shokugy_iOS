//
//  TestViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/11/27.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginBtn = FBSDKLoginButton()
        loginBtn.center = self.view.center
        self.view.addSubview(loginBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
