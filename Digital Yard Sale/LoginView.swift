//
//  LoginView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/24/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift


protocol LoginDelegate: AnyObject {
    func loginInformationVerified()
}

class LoginView:UIView {
    
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var passwordLabel: UILabel!
    
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet var loginSubmit:UIButton!
    
    weak var loginDelegate: LoginDelegate!
    
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
        let nib = UINib.init(nibName:"LoginView",bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        //give the login button purpose
        loginSubmit.addTarget(self, action: #selector(submitPushed), for: .touchDown)
    }
    func submitPushed(sender:AnyObject) {
        //verify user name and password
        let realm = AppDelegate.getInstance().realm!

        var users: Results<User>!

        print("trying to validate login information")
        
        users = realm.objects(User.self);
        
        for i in 0..<users.count {
            let userT = users[i]
            if(usernameField?.text == userT.username) {
                print("user name exists")
                if(passwordField?.text == userT.password) {
                    print("correct password")
                    //call segue to home screen
                    loginDelegate?.loginInformationVerified()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.userID = i
                }
                else {
                    print("incorrect password")
                }
            }
        }
    }
}
