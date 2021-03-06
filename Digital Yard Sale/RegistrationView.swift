//
//  RegistrationView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift

protocol RegistrationDelegate: AnyObject {
    func registerFieldsValid(sender:AnyObject)
}

class RegistrationView: UIView {
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var joinButton: UIButton!
    
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var errorLabel: UILabel!
    
    weak var registerDelegate: RegistrationDelegate!
    
    override init(frame aFrame:CGRect) {
        super.init(frame: aFrame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //setup the view
    func setupView() {
        //initalize nib
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "RegistrationView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        //give button call to action
        joinButton.addTarget(self, action: #selector(joinButtonPressed), for: .touchUpInside)
        
        backgroundImage.image = UIImage(named: "welcome.jpg")
    }
    
    func joinButtonPressed() {
        var error = false
        
        //see if feilds are empty
        if (!usernameField.hasText) {
            error = true
            self.errorLabel.text = "Please Fill in the Username Field"
        }
        if (!passwordField.hasText) {
            error = true
            self.errorLabel.text = "Please Fill in the Password Field"
        }
        if (!emailField.hasText) {
            error = true
            self.errorLabel.text = "Please Fill in the Email Field"
        }
        //Check if the fields are too small
        if((usernameField.text?.characters.count)! <= 4) {
            error = true
            self.errorLabel.text = "Usernames must be at least 5 characters long."
        }
        if((passwordField.text?.characters.count)! <= 4) {
            error = true
            self.errorLabel.text = "Passwords must be at least 5 characters long."
        }
        //check if the username already exists
        let realm = AppDelegate.getInstance().realm!
        let users = realm.objects(User.self)
        
        for user in users {
            if (usernameField.text == user.username) {
                error = true
                self.errorLabel.text = "Username already exists!"
            }
        }
        
        //Push out the error
        if(error) {
            errorLabel.textColor = .red
            errorLabel.numberOfLines = 0
            joinButton.backgroundColor = .gray
        }
        else {
            let realm = AppDelegate.getInstance().realm!
            
            var users : Results<User>!
            
            try! realm.write {
                users = realm.objects(User.self)
                let user = User(usernameT: (usernameField?.text)!, passwordT: (passwordField?.text)!, emailT: (emailField?.text)!, userIDT: users.count)
                realm.add(user)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.userID = users.count - 1
            }
            registerDelegate.registerFieldsValid(sender: self)
        }
        
    }

    //close the text editing field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}


