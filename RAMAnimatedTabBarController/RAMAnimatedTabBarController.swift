//  AnimationTabBarController.swift
//
// Copyright (c) 11/10/14 Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class RAMAnimatedTabBarItem: UITabBarItem {

    @IBOutlet weak var animation: RAMItemAnimation?
    @IBInspectable var textColor = UIColor.whiteColor()//(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)  //セレクトされてないときの色

    func playAnimation(icon: UIImageView, textLabel: UILabel){
        guard let animation = animation else {
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel)
    }

    func deselectAnimation(icon: UIImageView, textLabel: UILabel) {
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }

    func selectedState(icon: UIImageView, textLabel: UILabel) {
        animation?.selectedState(icon, textLabel: textLabel)
    }
}

class RAMAnimatedTabBarController: UITabBarController {

    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = []
    
    //---------fbLogoutProparty
    var isFirstAppear: Bool = true
    //----------
    
// MARK: life circle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containers = createViewContainers()
        //バーの色
        UITabBar.appearance().barTintColor = UIColor.whiteColor() //UIColor(red: 248/255, green: 116/255, blue: 31/255, alpha: 1)
        UITabBar.appearance().translucent = false
        createCustomIcons(containers)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //-------fbLogout作業--------
        if !isFirstAppear && selectedIndex == 0 {
            let items = tabBar.items as! [RAMAnimatedTabBarItem]
            var animationItem: RAMAnimatedTabBarItem = items[0]
            var icon = iconsView[0].icon
            var textLabel = iconsView[0].textLabel
            animationItem.playAnimation(icon, textLabel: textLabel)
            
            animationItem = items[4]
            icon = iconsView[4].icon
            textLabel = iconsView[4].textLabel
            animationItem.deselectAnimation(icon, textLabel: textLabel)
        }
        isFirstAppear = false
        //---------------
    }
    
    
//    func makeUIImage(imageName: String) -> UIImage {
//        return UIImage(named: imageName)!
//    }

// MARK: create methods

    func createCustomIcons(containers : [String: UIView]) {

        if let items = tabBar.items as? [RAMAnimatedTabBarItem] {
            
            let itemsCount = items.count as Int - 1
            
            for (index, item) in items.enumerate() {
                
                //----------defaultの文字の色
                item.textColor = UIColor(red: 186/255, green: 189/255, blue: 194/255, alpha: 1) //(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
                //-------------

                assert(item.image != nil, "add image icon in UITabBarItem")
                
                guard let container = containers["container\(itemsCount-index)"] else
                {
                    print("No container given")
                    continue
                }
                
                container.tag = index

                let icon = UIImageView(image: item.image?.imageWithRenderingMode(.AlwaysTemplate))
                icon.translatesAutoresizingMaskIntoConstraints = false
                icon.tintColor = UIColor(red: 186/255, green: 189/255, blue: 194/255, alpha: 1) //(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
                //defaultでのアイコンの色　imagewithrenderingmode追加

                // text
                let textLabel = UILabel()
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.textColor = item.textColor
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.translatesAutoresizingMaskIntoConstraints = false

                container.addSubview(icon)
                
                if let itemImage = item.image {
                    createConstraints(icon, container: container, size: itemImage.size, yOffset: -3)
                }

                container.addSubview(textLabel)
                
                if let tabBarItem = tabBar.items {
                    let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count) - 5.0
                    createConstraints(textLabel, container: container, size: CGSize(width: textLabelWidth , height: 10), yOffset: 19)
                }

                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)

                if 0 == index { // selected first elemet
                    item.selectedState(icon, textLabel: textLabel)
                }

                item.image = nil
                item.title = ""
            }
        }
    }

    func createConstraints(view: UIView, container: UIView, size: CGSize, yOffset: CGFloat) {

        let constX = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1,
            constant: 0)
        container.addConstraint(constX)

        let constY = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1,
            constant: yOffset)
        container.addConstraint(constY)

        let constW = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.width)
        view.addConstraint(constW)

        let constH = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.height)
        view.addConstraint(constH)
    }

    func createViewContainers() -> [String: UIView] {

        var containersDict = [String: UIView]()
        
        guard let tabBarItems = tabBar.items else
        {
            return containersDict
        }
        
        let itemsCount: Int = tabBarItems.count - 1

        for index in 0...itemsCount {
            let viewContainer = createViewContainer()
            containersDict["container\(index)"] = viewContainer
        }

        var formatString = "H:|-(0)-[container0]"
        for index in 1...itemsCount {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        let constranints = NSLayoutConstraint.constraintsWithVisualFormat(formatString,
                                                                    options:NSLayoutFormatOptions.DirectionRightToLeft,
                                                                    metrics: nil,
                                                                      views: containersDict)
        view.addConstraints(constranints)

        return containersDict
    }

    func createViewContainer() -> UIView {
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.clearColor() // for test
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewContainer)

        // add gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapHandler:")
        tapGesture.numberOfTouchesRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)

        // add constrains
        let constY = NSLayoutConstraint(item: viewContainer,
                                   attribute: NSLayoutAttribute.Bottom,
                                   relatedBy: NSLayoutRelation.Equal,
                                      toItem: view,
                                   attribute: NSLayoutAttribute.Bottom,
                                  multiplier: 1,
                                    constant: 0)

        view.addConstraint(constY)

        let constH = NSLayoutConstraint(item: viewContainer,
                                   attribute: NSLayoutAttribute.Height,
                                   relatedBy: NSLayoutRelation.Equal,
                                      toItem: nil,
                                   attribute: NSLayoutAttribute.NotAnAttribute,
                                  multiplier: 1,
                                    constant: tabBar.frame.size.height)
        viewContainer.addConstraint(constH)

        return viewContainer
    }

// MARK: actions

    func tapHandler(gesture:UIGestureRecognizer) {

        let items = tabBar.items as! [RAMAnimatedTabBarItem]

        let currentIndex = gesture.view!.tag
        if selectedIndex != currentIndex {
            let animationItem : RAMAnimatedTabBarItem = items[currentIndex]
            let icon = iconsView[currentIndex].icon
            let textLabel = iconsView[currentIndex].textLabel
            animationItem.playAnimation(icon, textLabel: textLabel)

            let deselelectIcon = iconsView[selectedIndex].icon
            let deselelectTextLabel = iconsView[selectedIndex].textLabel
            let deselectItem = items[selectedIndex]
            deselectItem.deselectAnimation(deselelectIcon, textLabel: deselelectTextLabel)

            selectedIndex = gesture.view!.tag
        }
        
    }

    //-----消してもうまくいく
    func setSelectIndex(from from: Int, to: Int) {
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        items[from].deselectAnimation(iconsView[from].icon, textLabel: iconsView[from].textLabel)
        items[to].playAnimation(iconsView[to].icon, textLabel: iconsView[to].textLabel)
    }
}


