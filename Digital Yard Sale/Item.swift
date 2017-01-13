//
//  Item.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/29/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Item: Object {
    
    dynamic var itemName = ""
    
    dynamic var itemDescription = ""
    
    dynamic var price = Double(0.00)
    
    dynamic var priceAsString = ""
    
    dynamic var conditionRating = 5
    
    dynamic var category: Category?
    
    dynamic var itemID = -1
    
    dynamic var image = ""
    
    var reviews = List<Review>()
    
    convenience init(itemNameT: String, itemDescriptionT: String, priceT: Double, conditionRatingT: Int, categoryT: Category,image: String) {
        self.init()
        self.itemName = itemNameT
        self.itemDescription = itemDescriptionT
        self.price = priceT
        self.conditionRating = conditionRatingT
        self.category = categoryT
        self.image = image
        
        //set the string of price to two places
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        let tempNum = NSNumber(value: price)
        let temp = numberFormatter.string(from: tempNum)
        self.priceAsString = temp!
        
        let realm = AppDelegate.getInstance().realm!
        let items = realm.objects(Item.self)
        itemID = items.count
    }
}
