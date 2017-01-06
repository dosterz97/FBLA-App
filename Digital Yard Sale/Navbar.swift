//
//  Navbar.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/25/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

protocol NavbarDelegate: AnyObject {
    func navbarButtonPressed(sender:UIButton)
}

enum ButtonTags: Int {
    case home = 0,shop,cart,about,login,register
}

class Navbar: UIView {
    
    @IBOutlet var homeButton: UIButton!
    
    @IBOutlet var shopButton: UIButton!
    
    @IBOutlet var cartButton: UIButton!
    
    @IBOutlet var aboutButton: UIButton!
    
    weak var navDelegate: NavbarDelegate!
    
    override init(frame aFrame:CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //set up the nib
    func setupView() {
        //nib initialization
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "NavbarView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        addSubview(view)
        
        //Give the buttons a tag to be recognized later
        homeButton.tag = ButtonTags.home.rawValue
        shopButton.tag = ButtonTags.shop.rawValue
        cartButton.tag = ButtonTags.cart.rawValue
        aboutButton.tag = ButtonTags.about.rawValue
        
        //Give buttons call to action upon beign pressed
        homeButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        aboutButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func buttonPressed(sender: UIButton) {
        navDelegate.navbarButtonPressed(sender: sender)
    }
}
