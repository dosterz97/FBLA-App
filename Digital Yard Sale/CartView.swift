//
//  CartView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class CartView: UIView, NavbarDelegate {
    
    @IBOutlet var navbar: Navbar!
    
    weak var cartDelegate: MainViewDelegate!
    
    //required intializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        navbar.navDelegate = self
    }
    
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "CartView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    //when a navbar button is pressed, segue using the main view delegate
    func navbarButtonPressed(sender: UIButton) {
        //home
        if (sender.tag == ButtonTags.home.rawValue) {
            print("home button has been selected")
            cartDelegate.navbarButtonPressed(sender: "CartToHomeSegueID")
        }
            //shop
        else if (sender.tag == ButtonTags.shop.rawValue) {
            print("shop button has been selected")
            cartDelegate.navbarButtonPressed(sender: "CartToShopSegueID")
        }
            //cart
        else if (sender.tag == ButtonTags.cart.rawValue) {
            print("cart button has been selected")
            //do nothing
        }
            //about
        else if (sender.tag == ButtonTags.about.rawValue) {
            print("about button has been selected")
            cartDelegate.navbarButtonPressed(sender: "CartToAboutSegueID")
        }

    }
}
