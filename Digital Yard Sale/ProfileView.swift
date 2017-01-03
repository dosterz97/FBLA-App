//
//  ProfileView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/29/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

protocol profileDelegate: AnyObject {
    func logoutButtonPushed(sender:AnyObject)
}

class ProfileView: UIView {
    
    @IBOutlet var logoutButton: UIButton!
    
    weak var profileDel: profileDelegate!
    
    //required intializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "ProfileView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        logoutButton.addTarget(self, action: #selector(buttonPushed), for: .touchUpInside)
    }
    
    //logout button pressed
    func buttonPushed(sender: AnyObject) {
        profileDel.logoutButtonPushed(sender: self)
    }
}
