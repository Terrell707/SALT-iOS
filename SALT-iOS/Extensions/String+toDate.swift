//
//  String+toDate.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/26/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String = "MM/dd/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
