//
//  PaymentView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/9/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import UIKit

class PaymentView: UIView, UITextFieldDelegate {
    
    @IBOutlet var cardNumberField: UITextField!
    
    @IBOutlet var securityCodeField: UITextField!
    
    @IBOutlet var expirationDateField: UITextField!
    
    @IBOutlet var firstNameField: UITextField!
    
    @IBOutlet var lastNameField: UITextField!
    
    @IBOutlet var addressField: UITextField!
    
    @IBOutlet var finishedButton: UIButton!
    
    @IBOutlet var totalCost: UILabel!
    
    var total: Double!
    
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
        let nib = UINib.init(nibName: "PaymentView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        addressField.delegate = self
        
        finishedButton.addTarget(self, action: #selector(doneWithForm), for: .touchUpInside)
    }
    
    func viewAppearing() {
        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var user = User()
        try! realm.write {
            let users = realm.objects(User.self);
            user = users[userNum!]
        }
        
        for item in user.userCart {
            total = item.price
        }
        print(total)
        
        
    }
    
    func doneWithForm() {
        //validate information
        guard  cardNumberField.hasText,
        securityCodeField.hasText,
        expirationDateField.hasText,
        firstNameField.hasText,
        lastNameField.hasText,
        addressField.hasText
        else { return }

        //Update the money raised
        AppDelegate.getInstance().money? += total
        
        
        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var user = User()
        try! realm.write {
            //Remove items from the users cart
            let users = realm.objects(User.self);
            user = users[userNum!]
            user.userCart.removeAll()
            
            //Remove items from the realm
        }
        
        //end editing
        // UITextFieldDelegate
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            // User finished typing (hit return): hide the keyboard.
            textField.resignFirstResponder()
            return true
        }

        
    }
}

