//
//  Office.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/24/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

struct Office {
    var code: String?
    var name: String?
    var address: Address?
    var phoneNumber: String?
    var email: String?
    var can: String?
    var pay: Double?
    
    // Creates an empty office.
    init(code: String? = nil, name: String? = nil, address: Address? = nil, phoneNumber: String? = nil,
         email: String? = nil, can: String? = nil, pay: Double? = nil) {
        
        self.code = code
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.email = email
        self.can = can
        self.pay = pay
    }
}
