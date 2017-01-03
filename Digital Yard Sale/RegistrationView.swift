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
    
    @IBOutlet var joinButton: UIButton!
    
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordLabel:UILabel!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var emailLabel: UILabel!
    
    @IBOutlet var emailField: UITextField!
    
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
    }
    
    func joinButtonPressed() {
        let realm = AppDelegate.getInstance().realm!
        
        var users : Results<User>!
        
        let user = User(usernameT: (usernameField?.text)!, passwordT: (passwordField?.text)!, emailT: (emailField?.text)!)
        try! realm.write {
            realm.add(user)
            users = realm.objects(User.self);
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.userID = users.count - 1
        }
        
        
        
        
        registerDelegate.registerFieldsValid(sender: self)
    }
}
