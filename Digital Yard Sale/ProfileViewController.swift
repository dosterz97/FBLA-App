//
//  ProfileViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/29/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, profileDelegate {
    
    @IBOutlet var profileView: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.profileDel = self
        self.navigationItem.title = "Profile"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func logoutButtonPushed(sender:AnyObject) {
        self.performSegue(withIdentifier: "ProfileToWelcomeSegueID", sender: sender)
    }
}
