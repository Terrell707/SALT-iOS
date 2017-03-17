//
//  Ticket.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 2/18/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

struct Ticket {
    
    // Ticket Information
    var orderDate: Date?
    let callOrderNo: String?
    var claimantFirstName: String?
    var claimantLastName: String?
    let ticketNo: Int?
    var bpaNo: String?
    var can: Int?
    let hearingSite: String?
    let vendorTin: String?
    var soc: String?
    var usageDate: Date?
    var usageTime: Date?
    var rate: Double?
    var onTheRecord: Bool?
    var fileType: FileType?
    
    // Hearing Informaton
//    var judge: Judge?
//    var representatives: [Expert]?
//    var vocationals: [Expert]?
//    var medicals: [Expert]?
//    var interpreters: [Expert]?
    
    enum FileType: Int {
        case Digital = 0;
        case Partial = 1;
        case Paper = 2;
    }
}
