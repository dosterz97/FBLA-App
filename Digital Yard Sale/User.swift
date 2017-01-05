//
//  User.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/29/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var username = ""
    
    dynamic var password = ""

    dynamic var email = ""
    
    dynamic var money = 0
    
    dynamic var userID = -1
    
    var userCart = List<Item>()
    
    convenience init(usernameT: String, passwordT: String, emailT: String, userIDT: Int) {
        self.init()
        self.username = usernameT
        self.password = passwordT
        self.email = emailT
        self.userID = userIDT
    }    
}
