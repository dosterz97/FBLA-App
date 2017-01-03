//
//  WelcomeViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/21/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController,WelcomeDelegate {
    
    @IBOutlet var loginView: WelcomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.welcomeDelegate = self
        self.navigationItem.title = "Welcome"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    func onButtonPressed(sender: UIButton) {
        //Do Segue to view controller based on the object
        if (sender.tag == ButtonTags.login.rawValue) {
            self.performSegue(withIdentifier: "WelcomeToLoginSegueID", sender: nil)
        }
        else if (sender.tag == ButtonTags.register.rawValue) {
            self.performSegue(withIdentifier: "WelcomeToRegistrationSegueID", sender: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
}