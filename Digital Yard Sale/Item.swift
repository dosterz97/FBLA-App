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
    
    dynamic var category = 0
    
    var reviews = List<Review>()
    
    convenience init(itemNameT: String, itemDescriptionT: String, priceT: Int, conditionRatingT: Int, categoryT: Int) {
        self.init()
        itemName = itemNameT
        itemDescription = itemDescriptionT
        price = priceT
        conditionRating = conditionRatingT 
        category = categoryT
    }
}
