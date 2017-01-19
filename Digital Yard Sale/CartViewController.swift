//
//  CartViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, MainViewDelegate, CategoryViewControllerDelegate, CartToItemDelegate {
    
    @IBOutlet var cartView: CartView!
    
    weak var cartDelegate: CategoryViewControllerDelegate!

    //needed initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.cartDelegate = self
        cartView.cartToItemDelegate = self
        self.navigationItem.title = "Cart"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        cartView.viewLoading()
    }
    
    //segue with ID given from the main view delegate
    func navbarButtonPressed(sender: String) {
        self.performSegue(withIdentifier: sender, sender: nil)
    }
    
    //there is no profile button on this page
    func profileButtonPressed(sender: AnyObject) {
        //do nothing
    }
    
    //segue to the Item that has been selected
    func itemClicked(sender: Item) {
        self.performSegue(withIdentifier: "CartToItemSegueID", sender: nil)
        self.cartDelegate.itemClicked(sender: sender)
    }
    
    //set the cart delegate to be the current item VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemVC = segue.destination as? ItemViewController {
            cartDelegate = itemVC
        }
    }
    
    //work around multiple inheritance
    func itemSelected(sender: Item) {
        itemClicked(sender: sender)
    }

    //segue to payment page 
    func checkOutPressed() {
        self.performSegue(withIdentifier: "CartToPaymentSegueID", sender: nil)
    }
    
    //segue to payment page
    func logoutPressed() {
        self.performSegue(withIdentifier: "CartToWelcomeSegueID", sender: nil)
    }
}
