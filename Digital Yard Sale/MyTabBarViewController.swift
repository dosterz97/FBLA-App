//
//  MyTabBarViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/10/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import UIKit

class MyTabViewController: UITabBarController {
    
    var myTabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTabBar = self.tabBar
        myTabBar.barTintColor = UIColor.black
        self.title = "Home"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        //Change size of the Tab Bar
        var tabFrame = self.myTabBar.frame
        tabFrame.size.height = 100
        tabFrame.origin.y = self.view.frame.size.height - 100
        self.myTabBar.frame = tabFrame
        
        //Give Styles to each of the tabs
        myTabBar.items?[0].title = "About"
        myTabBar.items?[1].title = "Home"
        myTabBar.items?[2].title = "Shop"
        myTabBar.items?[3].title = "Cart"
        
        for item in myTabBar.items! {
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -40)
            let attributes: [String: AnyObject] = [NSFontAttributeName:UIFont(name: "Arial", size: 18)!, NSForegroundColorAttributeName: UIColor.white]
            item.setTitleTextAttributes(attributes, for: .normal)
            let myGreen = UIColor(colorLiteralRed: 27/255, green: 123/255, blue: 70/255, alpha: 1)
            let activeAttributes: [String: AnyObject] = [NSFontAttributeName:UIFont(name: "Arial", size: 18)!, NSForegroundColorAttributeName: myGreen]
            item.setTitleTextAttributes(activeAttributes, for: .selected)
        }
    }
}
