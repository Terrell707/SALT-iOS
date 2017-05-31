//
//  Address.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/28/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

struct Address {
    var street: String?
    var street2: String?
    var city: String?
    var state: String?
    var zip: String?
    
    init(street: String? = nil, street2: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil) {
        self.street = street
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    func format(withNewlines: Bool = true) -> String? {
        var address: String? = nil
        var space: String
        
        // Formats the address with newlines if user specifies. Otherwise, uses spaces.
        if withNewlines {
            space = "\n"
        } else {
            space = " "
        }
        
        if  let street = self.street,
            let city = self.city,
            let state = self.state,
            let zip = self.zip {
            
            if let street2 = self.street2 {
                address = "\(street) \(street2)\(space)\(city) \(state) \(zip)"
            } else {
                address = "\(street)\(space)\(city) \(state) \(zip)"
            }
        }
        
        return address
    }
}
