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
    var ticketNo: Int?
    var claimantFirstName: String?
    var claimantLastName: String?
    var orderDate: Date?
    var callOrderNo: String?
    var bpaNo: String?
    var can: Int?
    var vendorTin: String?
    var soc: String?
    var usageDate: Date?
    var rate: Double?
    var onTheRecord: Bool?
    var fileType: FileType?
    
    // Hearing Informaton
    var hearingSite: Office?
    var judge: Judge?
    var representative: Expert?
    var vocational: Expert?
    var medicals: [Expert]?
    var interpreter: Expert?
    
    enum FileType {
        case Digital
        case Partial
        case Paper
    }
    
    // Create an empty ticket.
    init(ticketNo: Int? = nil, firstName: String? = nil, lastName: String? = nil, orderDate: Date? = nil,
         callOrderNo: String? = nil, bpaNo: String? = nil, can: Int? = nil, vendorTin: String? = nil,
         soc: String? = nil, usageDate: Date? = nil, rate: Double? = nil, onTheRecord: Bool? = nil,
         fileType: FileType? = nil, hearingSite: Office? = nil, judge: Judge? = nil, representative: Expert? = nil,
         vocational: Expert? = nil, medicals: [Expert]? = nil, interpreter: Expert? = nil) {
        
        // Ticket Information
        self.ticketNo = ticketNo
        self.claimantFirstName = firstName
        self.claimantLastName = lastName
        self.orderDate = orderDate
        self.callOrderNo = callOrderNo
        self.bpaNo = bpaNo
        self.can = can
        self.vendorTin = vendorTin
        self.soc = soc
        self.usageDate = usageDate
        self.rate = rate
        self.onTheRecord = onTheRecord
        self.fileType = fileType
        
        // Hearing Information
        self.hearingSite = hearingSite
        self.judge = judge
        self.representative = representative
        self.vocational = vocational
        self.medicals = medicals
        self.interpreter = interpreter
    }
}
