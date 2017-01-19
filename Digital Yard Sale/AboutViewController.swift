/*
 AboutViewController.swift
 Displays the view for the about page given by the nib
 and handles any transitions to other view controllers from this page
 */

import UIKit

class AboutViewController: UIViewController,MainViewDelegate {
    
    @IBOutlet var aboutView: AboutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutView.aboutDelegate = self
        self.navigationItem.title = "About"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func navbarButtonPressed(sender: String) {
        self.performSegue(withIdentifier: sender, sender: nil)
    }
    
    func profileButtonPressed(sender: AnyObject) {
        self.performSegue(withIdentifier: "AboutToWelcomeSegueID", sender: nil)
    }
}
