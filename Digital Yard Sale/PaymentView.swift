//
//  PaymentView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/9/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import UIKit

class PaymentView: UIView {
    
    @IBOutlet var cardNumberField: UITextField!
    
    @IBOutlet var securityCodeField: UITextField!
    
    @IBOutlet var expirationDateField: UITextField!
    
    @IBOutlet var firstNameField: UITextField!
    
    @IBOutlet var lastNameField: UITextField!
    
    @IBOutlet var addressField: UITextField!
    
    @IBOutlet var finishedButton: UIButton!
    
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
        
        finishedButton.addTarget(self, action: #selector(doneWithForm), for: .touchUpInside)
    }
    
    func doneWithForm() {
        guard  cardNumberField.hasText,
        securityCodeField.hasText,
        expirationDateField.hasText,
        firstNameField.hasText,
        lastNameField.hasText,
        addressField.hasText
        else { return }
        print("success")
    }
}

