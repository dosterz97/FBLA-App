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
            conditionText = "Unkown"
        }
        itemCondition.text = "Condition: " + conditionText!
        
        //set up button target
        addToCartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
        
        //load item image
        Alamofire.request("https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg").responseData { response in
            guard let data = response.result.value else {
                debugPrint(response)
                return
            }
            self.itemPicture.contentMode = .scaleAspectFit
            self.itemPicture.image = UIImage(data: data)
        }
    }
    
    func cartButtonPressed() {
        //get the users ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        let realm = AppDelegate.getInstance().realm!
        
        //Add the item to the cart
        try! realm.write {
            let users = realm.objects(User.self);
            let user = users[userNum!]
            user.userCart.append(activeItem)
        }
        
        itemDelegate.addItemToCart(sender: self.activeItem)
    }
    
    func commentButtonPressed() {
        itemDelegate.goToItemComments(sender: activeItem.itemID)
    }
}
