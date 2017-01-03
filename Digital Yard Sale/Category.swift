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
    
    convenience init(nameT: String, picURLT: String, itemsT: List<Item>) {
        self.init()
        name = nameT
        picURL = picURLT
        items = itemsT
    }
}
