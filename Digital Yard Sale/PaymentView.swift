//
//  PaymentView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/9/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import UIKit

class PaymentView: UIView, UITextFieldDelegate {
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var cardNumberField: UITextField!
    
    @IBOutlet var securityCodeField: UITextField!
    
    @IBOutlet var expirationDateField: UITextField!
    
    @IBOutlet var firstNameField: UITextField!
    
    @IBOutlet var lastNameField: UITextField!
    
    @IBOutlet var addressField: UITextField!
    
    @IBOutlet var finishedButton: UIButton!
    
    @IBOutlet var totalCost: UILabel!
    
    @IBOutlet var errorLabel: UILabel!
    
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
        
        backgroundImage.image = UIImage(named: "Welcome.jpg")
    }
    
    func viewAppearing() {
        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var user = User()
        try! realm.write {
            let users = realm.objects(User.self)
            user = users[userNum!]
        }
        
        //Add up the value of the cart
        total = 0
        for item in user.userCart {
            total = total + item.price
        }
        
        //Set the price label 
        totalCost.text = "$0.00"
        if (total > 0) {
            //set the string of price to two places
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            
            let tempNum = NSNumber(value: total!)
            let temp = numberFormatter.string(from: tempNum)
            totalCost.text = "$" + temp!
        }
        
        
    }
    
    func doneWithForm() {
        //validate information
        guard  cardNumberField.hasText,
        securityCodeField.hasText,
        expirationDateField.hasText,
        firstNameField.hasText,
        lastNameField.hasText,
        addressField.hasText,
        securityCodeField.text?.characters.count == 3,
        expirationDateField.text?.characters.count == 5,
        cardNumberField.text?.characters.count == 19
        else {
            errorLabel.textColor = .red
            errorLabel.numberOfLines = 0
            errorLabel.text = "Please fill in all of the fields"
            
            let securityField = securityCodeField.text?.characters.count
            if (securityField != 3 && securityField != 0) {
                errorLabel.text = "Invalid Security Code"
            }
            let cardField = cardNumberField.text?.characters.count
            if (cardField != 19 && cardField != 0) {
                errorLabel.text = "Invalid Card Number"
            }
            let dateField = expirationDateField.text?.characters.count
            if (dateField != 5 && cardField != 0) {
                errorLabel.text = "Invalid Expiration Date"
            }
            return
        }

        //Update the money raised
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.money! += total
        //get the current user ID
        let userNum = appDelegate.userID
        
        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var user = User()
        try! realm.write {
            //Get user
            let users = realm.objects(User.self)
            user = users[userNum!]
            
            //Remove items from the realm
            let items = realm.objects(Item.self)
            for userItem in user.userCart {
                if items.contains(userItem) {
                    realm.delete(userItem)
                }
            }
            //Set general info so money lives beyond memory 
            let generalInfo = realm.objects(GeneralInfo.self)
            generalInfo[0].moneyRaised = appDelegate.money!
            //Remove items from the users cart
            user.userCart.removeAll()
        }
        
        //Button styles
        self.finishedButton.backgroundColor = .gray
        self.finishedButton.setTitle("Thank You!", for: UIControlState.normal)
    }
    
    //end editing
    // UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
}

