//
//  CartViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, MainViewDelegate {
    
    @IBOutlet var cartView: CartView!

    //needed initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.cartDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //segue with ID given from the main view delegate
    func navbarButtonPressed(sender: String) {
        self.performSegue(withIdentifier: sender, sender: nil)
    }
    
    //there is no profile button on this page
    func profileButtonPressed(sender: AnyObject) {
        //do nothing
    }
}
