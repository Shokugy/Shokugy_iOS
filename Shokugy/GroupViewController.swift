//
//  GroupViewController.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/23.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import UIKit
import SwiftyJSON

class GroupViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    var collectionView: UICollectionView!
    let groupLoginView = UIView()
    let newGroupView = UIView()
    var groupNameTextField: UITextField!
    var newGroupPasswordTextField: UITextField!
    var passwordConfTextField: UITextField!
    var groups: [Group] = []
    var receiveIsFirst: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        getGroups()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.collectionView.reloadData() //フェッチしなおさないとだめか
    }
    
    func getGroups() {
        groups = []
        GroupManager.getGroup { (json) -> Void in
            for i in 0 ..< json.count {
                self.makeGroupFromJSON(json[i])
            }
            
            self.collectionView.reloadData()
        }
    }
    
    func makeGroupFromJSON(json: JSON) {
        let group = Group()
        group.groupID = json["id"].int
        group.name = json["name"].string
        
        groups.append(group)
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.orangeColor()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 48
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 32, right: 16)
        flowLayout.itemSize = CGSizeMake(self.view.frame.width / 5 * 2, self.view.frame.width / 5 * 2)
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        collectionView = UICollectionView(frame: frame , collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.orangeColor()
        self.collectionView.registerNib(UINib(nibName: "GroupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "plus"), forState: .Normal)
        addButton.frame.size = CGSize(width: 120, height: 120)
        addButton.center = CGPoint(x: self.view.center.x, y: self.view.frame.height / 4 * 3)
        addButton.addTarget(self, action: "tapPlusButton", forControlEvents: .TouchUpInside)
        addButton.layer.shadowColor = UIColor.grayColor().CGColor
        addButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        addButton.layer.shadowOpacity = 0.6
        self.view.bringSubviewToFront(addButton)
        self.view.addSubview(addButton)
    }
      
    func tapPlusButton() {
        print("tapplusbutton")
        
        setNewGroupView()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.newGroupView.frame.origin.y = self.view.frame.origin.y - 64
        }

    }
    
    func makeGroupTitleLabel(title: String, point: CGPoint) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(25)
        label.sizeToFit()
        label.center = point
        return label
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! GroupCollectionViewCell
        cell.label.center = CGPoint(x: cell.frame.width / 2, y: cell.frame.height / 2)
        cell.label.font = UIFont.systemFontOfSize(cell.frame.width / 3 * 2 - 5)
        let groupTitle: String = groups[indexPath.item].name!
        cell.label.text = String(groupTitle[groupTitle.startIndex])
        
        let titleLabelPoint = CGPoint(x: cell.center.x, y: cell.frame.origin.y + cell.frame.height + 15)
        let groupTitleLabel = makeGroupTitleLabel(groupTitle, point: titleLabelPoint)
        self.collectionView.addSubview(groupTitleLabel)
        
        //デザイン修正　未完了 色とか
        cell.backgroundColor = UIColor.yellowColor()
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
        
        self.setGroupLoginView(indexPath.item)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.groupLoginView.frame.origin.y = self.view.frame.origin.y - 64
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //----------------------groupLoginView-------------------------------
    
    func setGroupLoginView(selectItemIndex: Int) {
        groupLoginView.frame = self.view.frame
        groupLoginView.frame.origin.y = self.view.frame.height
        groupLoginView.backgroundColor = UIColor.orangeColor()
        
        let groupInitTitleLabel = UILabel()
        let groupTitle = groups[selectItemIndex].name
        groupInitTitleLabel.text = String(groupTitle![(groupTitle?.startIndex)!])
        groupInitTitleLabel.textColor = UIColor.whiteColor()
        groupInitTitleLabel.textAlignment = NSTextAlignment.Center
        groupInitTitleLabel.font = UIFont.systemFontOfSize(120)
        groupInitTitleLabel.frame.size = CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
        groupInitTitleLabel.center = CGPoint(x: self.view.center.x, y: self.view.frame.height / 4)
        groupInitTitleLabel.backgroundColor = UIColor.yellowColor()
        groupInitTitleLabel.layer.cornerRadius = groupInitTitleLabel.frame.width / 2
        groupInitTitleLabel.clipsToBounds = true
        groupLoginView.addSubview(groupInitTitleLabel)
        
        let groupTitleLabel = UILabel()
        groupTitleLabel.text = groupTitle
        groupTitleLabel.textColor = UIColor.whiteColor()
        groupTitleLabel.textAlignment = NSTextAlignment.Center
        groupTitleLabel.font = UIFont.systemFontOfSize(40)
        groupTitleLabel.sizeToFit()
        groupTitleLabel.center = CGPoint(x: groupLoginView.center.x, y: groupInitTitleLabel.frame.origin.y + groupInitTitleLabel.frame.height + 25)
        groupLoginView.addSubview(groupTitleLabel)
        
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.textColor = UIColor.whiteColor()
        passwordLabel.textAlignment = NSTextAlignment.Center
        passwordLabel.font = UIFont.systemFontOfSize(35)
        passwordLabel.sizeToFit()
        passwordLabel.center = CGPoint(x: groupLoginView.center.x, y: groupTitleLabel.frame.origin.y + groupTitleLabel.frame.height + 40)
        groupLoginView.addSubview(passwordLabel)
        
        let passwordTextField = UITextField()
        passwordTextField.frame.size = CGSize(width: self.view.frame.width / 3 * 2, height: 40)
        passwordTextField.center = CGPoint(x: groupLoginView.center.x, y: passwordLabel.frame.origin.y + passwordLabel.frame.height + 32)
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = UIColor.whiteColor()
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.delegate = self
        groupLoginView.addSubview(passwordTextField)
        
        let backButton = UIButton()
        backButton.frame.size = CGSize(width: 44, height: 44)
        backButton.frame.origin = CGPoint(x: 10, y: 10)
        backButton.setImage(UIImage(named: "batu"), forState: .Normal)
        backButton.addTarget(self, action: "tapGroupLoginBackButton", forControlEvents: .TouchUpInside)
        groupLoginView.addSubview(backButton)
        
        self.view.addSubview(groupLoginView)
        
    }
    
    func tapGroupLoginBackButton() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.groupLoginView.frame.origin.y = self.view.frame.height
            }) { (finished) -> Void in
                self.groupLoginView.removeFromSuperview()
        }
    }
    
    //---------------------------------newGroupView-------------------------------
    
    func setNewGroupView() {
        newGroupView.frame = self.view.frame
        newGroupView.frame.origin.y = self.view.frame.height
        newGroupView.backgroundColor = UIColor.orangeColor()
        
        
        let groupNameLabel = UILabel()
        groupNameLabel.text = "Group Name"
        groupNameLabel.textAlignment = NSTextAlignment.Center
        groupNameLabel.textColor = UIColor.whiteColor()
        groupNameLabel.font = UIFont.systemFontOfSize(40)
        groupNameLabel.sizeToFit()
        groupNameLabel.center = CGPoint(x: self.view.center.x, y: self.view.frame.height / 4)
        newGroupView.addSubview(groupNameLabel)
        
        groupNameTextField = makeNewGroupTextField("Group Name(12文字以内）", standardFrame: groupNameLabel.frame)
        newGroupView.addSubview(groupNameTextField)
        
        let passwordLabel = makeNewGroupLabel("Password", standardFrame: groupNameTextField.frame)
        newGroupView.addSubview(passwordLabel)
        
        newGroupPasswordTextField = makeNewGroupTextField("Password(3文字以上）", standardFrame: passwordLabel.frame)
        newGroupView.addSubview(newGroupPasswordTextField)
        
        let passwordConfLabel = makeNewGroupLabel("Password Confirmation", standardFrame: newGroupPasswordTextField.frame)
        newGroupView.addSubview(passwordConfLabel)
        
        passwordConfTextField = makeNewGroupTextField("Password Confirmation", standardFrame: passwordConfLabel.frame)
        newGroupView.addSubview(passwordConfTextField)
        
        
        
        let createButton = UIButton()
        createButton.setTitle("Create", forState: .Normal)
        createButton.titleLabel?.font = UIFont.systemFontOfSize(30)
        createButton.sizeToFit()
        createButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        createButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
        createButton.center = CGPoint(x: self.view.center.x, y: passwordConfTextField.frame.origin.y + passwordConfTextField.frame.height + 32)
        createButton.addTarget(self, action: "tapCreateButton", forControlEvents: .TouchUpInside)
        newGroupView.addSubview(createButton)
        
        let backButton = UIButton()
        backButton.frame.size = CGSize(width: 44, height: 44)
        backButton.frame.origin = CGPoint(x: 10, y: 10)
        backButton.setImage(UIImage(named: "batu"), forState: .Normal)
        backButton.addTarget(self, action: "tapNewGroupBackButton", forControlEvents: .TouchUpInside)
        newGroupView.addSubview(backButton)
        
        self.view.addSubview(newGroupView)
    }
    
    func tapNewGroupBackButton() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.newGroupView.frame.origin.y = self.view.frame.height
            }) { (finished) -> Void in
                self.newGroupView.removeFromSuperview()
        }
    }
    
    func tapCreateButton() {
        GroupManager.createGroup(groupNameTextField.text!, password: newGroupPasswordTextField.text!, passwordConf: passwordConfTextField.text!, callback: {
            self.getGroups()
        })
        newGroupView.removeFromSuperview()
    }
    
    func makeNewGroupLabel(name: String, standardFrame: CGRect) -> UILabel {
        let label = UILabel()
        label.text = name
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(35)
        label.sizeToFit()
        label.center = CGPoint(x: self.view.center.x, y: standardFrame.origin.y + standardFrame.height + 48)
        return label
    }
    
    func makeNewGroupTextField(name: String, standardFrame: CGRect) -> UITextField {
        let textField = UITextField()
        textField.frame.size = CGSize(width: self.view.frame.width / 3 * 2, height: 40)
        textField.center = CGPoint(x: self.view.center.x, y: standardFrame.origin.y + standardFrame.height + 32)
        textField.placeholder = name
        textField.backgroundColor = UIColor.whiteColor()
        textField.layer.cornerRadius = 10
        textField.delegate = self
        
        return textField
    }

}
