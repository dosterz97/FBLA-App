//
//  LoginViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/21/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, LoginDelegate {
    
    @IBOutlet var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginDelegate = self
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Login"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginInformationVerified() {
        self.performSegue(withIdentifier: "LoginToHomeSegueID", sender: nil)
    }
}
