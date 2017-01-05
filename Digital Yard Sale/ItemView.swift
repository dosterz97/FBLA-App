//
//  ItemView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift

protocol ItemDelegate: AnyObject {
    func addItemToCart(sender: Item)
}

class ItemView: UIView {
    
    @IBOutlet var itemName: UILabel!
    
    @IBOutlet var itemDescription: UILabel!
    
    @IBOutlet var itemPrice: UILabel!
    
    @IBOutlet var itemCondition: UILabel!
    
    @IBOutlet var itemPicture: UIImageView!
    
    @IBOutlet var addToCartButton: UIButton!
    
    var activeItem: Item!
    
    weak var itemDelegate: ItemDelegate!
    
    //required intializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "ItemView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    func setupLabels() {
        //set up the text for the item labels
        itemName.text = activeItem.itemName
        itemDescription.text = activeItem.itemDescription
        itemPrice.text = activeItem.price.description
        itemCondition.text = activeItem.conditionRating.description
        
        //set up button target
        addToCartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
    }
    
    func cartButtonPressed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        let realm = AppDelegate.getInstance().realm!
        
        try! realm.write {
            let users = realm.objects(User.self);
            let user = users[userNum!]
            user.userCart.append(activeItem)
            print(user.userCart[0].itemName)
            print(user.username)
        }
        print("cartButtonPressed")
        itemDelegate.addItemToCart(sender: self.activeItem)
    }
}
