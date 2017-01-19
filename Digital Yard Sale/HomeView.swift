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
    
    @IBOutlet var backgroundPicture: UIImageView!
    
    @IBOutlet var profileButton: UIButton!
    
    @IBOutlet var moneyRaised: UILabel!
    
    @IBOutlet var precentRaised: UILabel!
    
    @IBOutlet var numberOfDaysLeft: UILabel!
    
    weak var homeDelegate: MainViewDelegate!
    
    var money: Double?
    
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
        
        //set up  days until the conference
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let NLCdate = formatter.date(from: "2017/06/24 00:00")
        let time = Int(((NLCdate?.timeIntervalSinceReferenceDate)! - date.timeIntervalSinceReferenceDate)/86400)
        numberOfDaysLeft.text = time.description + " days left!"
        
        backgroundPicture.image = UIImage(named: "welcome.jpg")

        view.sendSubview(toBack: backgroundPicture)//background picture to back
        
        //logout button image
        let image = UIImage(named: "user.png") //User by Jose Moya from the Noun Project
        profileButton.setImage(image, for: .normal)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.tintColor = .white
    }
    
    //animation of circle and update money whenever the view appears
    func viewAppearing() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        money = appDelegate.money
        //Set text values
        moneyRaised.text = "$0.00"
        if (money != 0) {
            //set the string of price to two places
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            
            let tempNum = NSNumber(value: money!)
            let temp = numberFormatter.string(from: tempNum)
            moneyRaised.text = "$" + temp!
        }
        precentRaised.text = ((money)!/100).description + "%"
        
        animation()
    }
    
    func animation() {
        //move to the middle to the screen
        self.moneyRaised.center.x -= self.bounds.width
        
        //animate
        UIView.animate(withDuration: 0.5, animations: {
            self.moneyRaised.center.x += self.bounds.width
        })
    }
    
    //the profile button
    func profileButtonPressed(sender:AnyObject) {
        homeDelegate.profileButtonPressed(sender: sender)
    }
}
