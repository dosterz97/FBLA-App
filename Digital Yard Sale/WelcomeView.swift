//
//  WelcomeView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/21/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//


import UIKit
import Alamofire

protocol WelcomeDelegate:AnyObject {
    func onButtonPressed(sender:UIButton)
}

class WelcomeView: UIView {
    
    @IBOutlet var welcomeBackground: UIImageView!

    @IBOutlet var greetingLabel: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var greetingBackground: UIView!
    
    weak var welcomeDelegate: WelcomeDelegate?
    
    override init(frame aFrame:CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        viewSetup()
    }
    
    func viewSetup() {
        //setup the nib
        let bundle = Bundle(for:type(of:self))
        let nib = UINib.init(nibName:"WelcomeView",bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        //load background image
        Alamofire.request("https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg").responseData { response in
            guard let data = response.result.value else {
                debugPrint(response)
                return
            }
            self.welcomeBackground.image = UIImage(data: data)
        }
        
        //give the buttons call to action
        loginButton.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        registerButton.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        
        //give the buttons tags
        loginButton.tag = ButtonTags.login.rawValue
        registerButton.tag = ButtonTags.register.rawValue
        
        //style the nib welcome header and background
        self.greetingBackground.frame.size.height = 140
        
    }
    
    func buttonPressed(sender: UIButton) {
        //begin segue to new screen
        welcomeDelegate?.onButtonPressed(sender:sender)
    }
}
