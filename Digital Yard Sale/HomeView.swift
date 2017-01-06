//
//  HomeView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/25/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func navbarButtonPressed(sender:String)
    func profileButtonPressed(sender:AnyObject)
}

class HomeView: UIView, NavbarDelegate {
    
    @IBOutlet var homeNav: Navbar!
    
    @IBOutlet var profileButton: UIButton!
    
    weak var homeDelegate: MainViewDelegate!
    
    override init(frame aFrame:CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        viewSetup()
        homeNav.navDelegate = self
    }
    
    //set up the nib
    func viewSetup() {
        // nib initailization
        let bundle = Bundle(for:type(of:self))
        let nib = UINib.init(nibName:"HomeView",bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        profileButton.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
    }
    
    //the profile button
    func profileButtonPressed(sender:AnyObject) {
        homeDelegate.profileButtonPressed(sender: sender)
    }
    
    
    func navbarButtonPressed(sender: UIButton) {
        //home
        if (sender.tag == ButtonTags.home.rawValue) {
            //do nothing
        }
        //shop
        else if (sender.tag == ButtonTags.shop.rawValue) {
            homeDelegate.navbarButtonPressed(sender: "HomeToShopSegueID")
        }
        //cart
        else if (sender.tag == ButtonTags.cart.rawValue) {
            homeDelegate.navbarButtonPressed(sender: "HomeToCartSegueID")
        }
        //about
        else if (sender.tag == ButtonTags.about.rawValue) {
            homeDelegate.navbarButtonPressed(sender: "HomeToAboutSegueID")
        }
    }
}
