//
//  Expert.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/24/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

struct Expert {
    var firstName: String?
    var lastName: String?
    var role: Role?
    
    enum Role {
        case Medical
        case Representative
        case Vocational
        case Interpreter
    }
}
