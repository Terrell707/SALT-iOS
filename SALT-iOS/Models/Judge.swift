//
//  Judge.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/24/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

struct Judge {
    var firstName: String?
    var lastName: String?
    var office: Office?
    var active: Bool?
    
    // Create an empty Judge.
    init(firstName: String? = nil, lastName: String? = nil, office: Office? = nil, active:Bool? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.office = office
        self.active = active
    }
}
