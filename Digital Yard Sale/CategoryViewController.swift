//
//  CategoryViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

protocol CategoryViewControllerDelegate: AnyObject {
    func itemClicked(sender: Item)
}

class CategoryViewController: UIViewController, CategoryViewDelegate  {
    
    @IBOutlet var categoryView: CategoryView!
    
    var category: Int!
    
    weak var categoryDelegate: CategoryViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.categoryDel = self
        categoryView.activeCategory = category
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //show the navigation top bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //peform segue to individual item controller based on the item
    func itemSelected(sender: Item) {
        self.performSegue(withIdentifier: "CategoryToItemSegueID", sender: sender)
        self.categoryDelegate.itemClicked(sender: sender)
    }
    
    //set the category delegate to be the current item VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemVC = segue.destination as? ItemViewController {
            categoryDelegate = itemVC
        }
    }
}

extension CategoryViewController: ShopViewControllerDelegate {
    func setCategory(sender: Int) {
        self.category = sender
    }
}

