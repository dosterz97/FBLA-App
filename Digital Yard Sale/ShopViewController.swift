/*
 ShopViewController.swift
 Displays the view for the shop page given by the nib
 and handles any transitions to other view controllers from this page
 */

import UIKit

class ShopViewController: UIViewController, MainViewDelegate {
    
    @IBOutlet var shopView: ShopView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopView.shopDelegate = self
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
        self.performSegue(withIdentifier: sender, sender: sender)
    }
    
    func profileButtonPressed(sender: AnyObject) {
        //do nothing
    }
}
