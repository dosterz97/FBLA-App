//
//  AboutView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class AboutView: UIView, NavbarDelegate {
    
    weak var aboutDelegate: MainViewDelegate!
    
    @IBOutlet var navbar: Navbar!
    
    //required initializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        navbar.navDelegate = self
    }
    
    //setup the view
    func setupView() {
        //basic nib initalization
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "AboutView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    func navbarButtonPressed(sender: UIButton) {
        //home
        if (sender.tag == ButtonTags.home.rawValue) {
            print("home button has been selected")
            aboutDelegate.navbarButtonPressed(sender: "AboutToHomeSegueID")
        }
            //shop
        else if (sender.tag == ButtonTags.shop.rawValue) {
            print("shop button has been selected")
            aboutDelegate.navbarButtonPressed(sender: "AboutToShopSegueID")
        }
            //cart
        else if (sender.tag == ButtonTags.cart.rawValue) {
            print("cart button has been selected")
            aboutDelegate.navbarButtonPressed(sender: "AboutToCartSegueID")
        }
            //about
        else if (sender.tag == ButtonTags.about.rawValue) {
            print("about button has been selected")
            //do nothing
        }

    }
}
