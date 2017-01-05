//
//  ItemViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class ItemViewController : UIViewController, ItemDelegate {
    
    var item: Item!
    
    @IBOutlet var itemView: ItemView!
    
    override func viewDidLoad() {
        itemView.activeItem = item
        super.viewDidLoad()
        itemView.setupLabels()
        itemView.itemDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //go back to the page previously on where item was
    func addItemToCart(sender: Item) {
        print("heyhey")
        self.dismiss(animated: true, completion: nil)//THIS DOESNT WORK WHY
    }
    
}

extension ItemViewController : CategoryViewControllerDelegate {
    func itemClicked(sender: Item) {
        self.item = sender
    }
}
