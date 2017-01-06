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
    
    var reviews = List<Review>()
    
    convenience init(itemNameT: String, itemDescriptionT: String, priceT: Int, conditionRatingT: Int, categoryT: Category) {
        self.init()
        itemName = itemNameT
        itemDescription = itemDescriptionT
        price = priceT
        conditionRating = conditionRatingT 
        category = categoryT
        
        let realm = AppDelegate.getInstance().realm!
        let items = realm.objects(Item.self)
        itemID = items.count
    }
}
