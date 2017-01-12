//
//  ItemViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift

protocol ItemViewControllerDelegate: AnyObject {
    func commentButtonClicked(sender: Int)
}

class ItemViewController : UIViewController, ItemDelegate {
    
    var item: Item!
    
    @IBOutlet var itemView: ItemView!
    
    weak var itemDelegate: ItemViewControllerDelegate!
    
    override func viewDidLoad() {
        itemView.activeItem = item//set the views item to that of the one passed by the category delegate
        super.viewDidLoad()
        itemView.setupLabels()//set up labels after the view is loaded when data is present
        itemView.itemDelegate = self
        self.navigationItem.title = item.itemName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        itemView.viewAppearing()
    }
    
    //go back to the page previously on where item was
    func addItemToCart(sender: Item) {
        self.dismiss(animated: true, completion: nil)//THIS DOESNT WORK WHY
    }
    
    //Go to the page with the items comments
    func goToItemComments(sender: Int) {
        self.performSegue(withIdentifier: "ItemToReviewSegueID", sender: nil)
        self.itemDelegate.commentButtonClicked(sender: sender)
    }
    
    //set the category delegate to be the current item VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reviewVC = segue.destination as? ReviewViewController {
            itemDelegate = reviewVC
        }
    }
}

extension ItemViewController : CategoryViewControllerDelegate {
    func itemClicked(sender: Item) {
        self.item = sender
    }
}
