//
//  AboutView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit


class AboutView: UIView {
    
    weak var aboutDelegate: MainViewDelegate!
    
    @IBOutlet var numberOfDaysLeft:UILabel!
    
    @IBOutlet var profileButton: UIButton!
    
    //required initializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //setup the view
    func setupView() {
        //basic nib initalization
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "AboutView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        //set up  days until the conference
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let NLCdate = formatter.date(from: "2017/06/24 00:00")
        
        let time = Int(((NLCdate?.timeIntervalSinceReferenceDate)! - date.timeIntervalSinceReferenceDate)/86400)
        numberOfDaysLeft.text = time.description + " days left!"
        
        //logout button image
        let image = UIImage(named: "user.png") //User by Jose Moya from the Noun Project
        profileButton.setImage(image, for: .normal)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.tintColor = .white
        profileButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    func logout() {
        aboutDelegate.profileButtonPressed(sender: self)
    }
}
