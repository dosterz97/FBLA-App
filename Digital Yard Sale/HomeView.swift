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

class HomeView: UIView {
    
    
    @IBOutlet var profileButton: UIButton!
    
    @IBOutlet var moneyRaised: UILabel!
    
    @IBOutlet var precentRaised: UILabel!
    
    weak var homeDelegate: MainViewDelegate!
    
    var money: Int?
    
    override init(frame aFrame:CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        viewSetup()
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
        
        money = AppDelegate.getInstance().money
        //Set text values
        moneyRaised.text = money?.description
        precentRaised.text = ((money)!/100).description + "%"
        
    }
    
    //the profile button
    func profileButtonPressed(sender:AnyObject) {
        homeDelegate.profileButtonPressed(sender: sender)
    }
}
