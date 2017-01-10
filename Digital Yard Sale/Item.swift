//
//  Item.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/29/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    dynamic var itemName = ""
    
    dynamic var itemDescription = ""
    
    dynamic var price = 0
    
    dynamic var conditionRating = 5
    
    dynamic var category: Category?
    
    dynamic var itemID = -1
    
    dynamic var picURL = ""
    
    var reviews = List<Review>()
    
    convenience init(itemNameT: String, itemDescriptionT: String, priceT: Int, conditionRatingT: Int, categoryT: Category,picURL: String) {
        self.init()
        self.itemName = itemNameT
        self.itemDescription = itemDescriptionT
        self.price = priceT
        self.conditionRating = conditionRatingT
        self.category = categoryT
        self.picURL = picURL
        
        let realm = AppDelegate.getInstance().realm!
        let items = realm.objects(Item.self)
        itemID = items.count
    }
}
