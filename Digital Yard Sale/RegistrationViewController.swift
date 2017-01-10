//
//  RegistrationViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, RegistrationDelegate {
    
    @IBOutlet var registerView: RegistrationView!
    
    //required overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.registerDelegate = self
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Registration"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerFieldsValid(sender: AnyObject) {
        performSegue(withIdentifier:"RegistrationToHomeSegueID", sender: nil)
    }
}
