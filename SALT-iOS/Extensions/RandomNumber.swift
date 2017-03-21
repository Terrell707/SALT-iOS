//
//  RandomNumber.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/17/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
    let length = (range.upperBound - range.lowerBound + 1).toIntMax()
    let value = arc4random().toIntMax() % length + range.lowerBound.toIntMax()
    return T(value)
}
