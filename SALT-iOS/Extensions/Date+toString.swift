//
//  Date+toString.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 2/26/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String = "MM/dd/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
