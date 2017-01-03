/*
HomeViewController.swift
Displays the view for the home page given by the nib
and handles any transitions to other view controllers from this page
*/

import UIKit

class HomeViewController: UIViewController, MainViewDelegate {
    
    @IBOutlet var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.homeDelegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //hide the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //the home view will give the segue ID upon type of button pressed
    func navbarButtonPressed(sender: String) {
        self.performSegue(withIdentifier: sender, sender: nil)
    }
    
    //home view segues to profile view
    func profileButtonPressed(sender: AnyObject) {
        self.performSegue(withIdentifier: "HomeToProfileSegueID", sender: nil)
    }
}
