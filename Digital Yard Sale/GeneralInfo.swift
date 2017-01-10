//
//  GeneralInfo.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/10/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import Foundation
import RealmSwift

class GeneralInfo: Object {
    
    dynamic var moneyRaised = 0
    
    convenience init(moneyRaised: Int) {
        self.init()
        self.moneyRaised = moneyRaised
    }
}
