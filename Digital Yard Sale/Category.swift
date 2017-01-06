//
//  Category.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/2/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    dynamic var name = ""
    
    dynamic var picURL = ""
    
    var items = List<Item>()
    
    dynamic var categoryID = -1
    
    convenience init(nameT: String, picURLT: String, itemsT: List<Item>) {
        self.init()
        name = nameT
        picURL = picURLT
        items = itemsT
        
        let realm = AppDelegate.getInstance().realm!
        let categories = realm.objects(Category.self)
        categoryID = categories.count
        
        for _ in 0..<categories.count {
            print (categories.description)
        }
        print(categories.count)
    }
}
