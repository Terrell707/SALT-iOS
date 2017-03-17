//
//  Double+toUSD.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 2/26/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

extension Double {
    func toUSD() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2;
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: self as NSNumber);
        return result!;
    }
}
