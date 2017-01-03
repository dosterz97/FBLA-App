//
//  ItemViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class ItemViewController : UIViewController {
    
    var item: Item!
    
    @IBOutlet var itemView: ItemView!
    
    override func viewDidLoad() {
        itemView.activeItem = item
        super.viewDidLoad()
        itemView.setupLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

extension ItemViewController : CategoryViewControllerDelegate {
    func itemClicked(sender: Item) {
        self.item = sender
    }
}
