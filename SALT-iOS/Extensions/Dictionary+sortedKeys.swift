//
//  Dictionary+subscript.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/20/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

extension Dictionary where Key: Comparable {
    var sortedKeysDescending: [Key] {
        get {
            return keys.sorted{ $0 > $1 }
        }
    }
    var sortedKeysAscending: [Key] {
        get {
            return keys.sorted{ $0 < $1 }
        }
    }
}
