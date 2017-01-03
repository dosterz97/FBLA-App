//
//  Review.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/29/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import Foundation
import RealmSwift

class Review: Object {

    dynamic var reviewerUsername = ""
    
    dynamic var review = ""
        
    convenience init(reviewerT: String, reviewT: String) {
        self.init()
    }
}
