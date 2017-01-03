/*
 ShopViewController.swift
 Displays the view for the shop page given by the nib
 and handles any transitions to other view controllers from this page
 */

import UIKit

protocol ShopViewControllerDelegate: AnyObject {
    func setCategory(sender: Category)
}

class ShopViewController: UIViewController, MainViewDelegate, ShopViewDelegate {
    
    @IBOutlet var shopView: ShopView!
    
    weak var shopDelegate: ShopViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopView.shopDelegate = self
        shopView.categoryDelegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //performs a segue to whatever page has been clicked
    func navbarButtonPressed(sender: String) {
        self.performSegue(withIdentifier: sender, sender: sender)
    }
    
    func profileButtonPressed(sender: AnyObject) {
        //do nothing
    }
    
    //set the shopVC delegate to be the current category VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let categoryVC = segue.destination as? CategoryViewController {
            shopDelegate = categoryVC
        }
    }
    //segue to the category page, load the list based upon which category is sent
    func categoryPressed(sender: Category) {
        self.performSegue(withIdentifier: "ShopToCategorySegueID", sender: nil)
        self.shopDelegate.setCategory(sender: sender)
    }
}
