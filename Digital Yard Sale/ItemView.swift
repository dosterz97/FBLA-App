//
//  ItemView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

protocol ItemDelegate: AnyObject {
    func addItemToCart(sender: Item)
    func goToItemComments(sender: Int)
}

class ItemView: UIView {
    
    @IBOutlet var itemName: UILabel!
    
    @IBOutlet var itemDescription: UILabel!
    
    @IBOutlet var itemPrice: UILabel!
    
    @IBOutlet var itemCondition: UILabel!
    
    @IBOutlet var itemPicture: UIImageView!
    
    @IBOutlet var addToCartButton: UIButton!
    
    @IBOutlet var commentButton: UIButton!
    
    var activeItem: Item!
    
    weak var itemDelegate: ItemDelegate!
    
    var itemAdded: Bool?
    
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
        itemAdded = false//for button styles
    }
    
    
    func viewAppearing() {
        
    }
    
    func setupLabels() {
        //set up the text for the item labels
        itemName.text = activeItem.itemName
        itemDescription.text = activeItem.itemDescription
        itemPrice.text = "$" + activeItem.priceAsString
        
        var conditionText: String?
        switch activeItem.conditionRating {
        case 1:
            conditionText = "Bad"
        case 2:
            conditionText = "Worn"
        case 3:
            conditionText = "Decent"
        case 4:
            conditionText = "Good"
        case 5:
            conditionText = "Great"
        default:
            conditionText = "Unknown"
        }
        itemCondition.text = "Condition: " + conditionText!
        
        //set up button target
        addToCartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
        
        //set item image
        self.itemPicture.image = UIImage(named: activeItem.image)
        self.itemPicture.contentMode = .scaleAspectFill
    }
    
    func cartButtonPressed() {
        if(!itemAdded!) {
            //get the users ID
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let userNum = appDelegate.userID
            
            let realm = AppDelegate.getInstance().realm!
            
            //Add the item to the cart
            try! realm.write {
                let users = realm.objects(User.self)
                let user = users[userNum!]
                user.userCart.append(activeItem)
            }
            itemDelegate.addItemToCart(sender: self.activeItem)
            
            addToCartButton.backgroundColor = .gray
            self.itemAdded! = true
        }
    }
    
    func commentButtonPressed() {
        itemDelegate.goToItemComments(sender: activeItem.itemID)
    }
}
