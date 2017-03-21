//
//  DataController.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 2/26/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

struct DataController {
    var tickets = [Ticket]()
    var monthYears = [String]()
    
    // Used to generate Sample Data
    let first_names = ["Adrian", "Joesph", "Talanda", "Alama", "Justin", "Jessica", "Christope", "Chris", "Tammy",
                       "Lucy", "Leo", "Barbara", "Patrick", "Tamar", "Crissle", "Derek", "Lyndsay", "Jonathan",
                       "Mandy", "Amanda", "Kenan", "Lakshmi", "Alex", "Marlon", "Jenika", "Tenika"]
    let last_names = ["Sullivan", "Williams", "Sao", "Orme", "Lee", "Ravel", "Toyo", "Jamar", "Saldana",
                      "Martinez", "Smith", "Park", "Bounds", "Chambers", "Davis", "Totah", "Entzel"]
    let sites = ["Sacramento", "San Jose", "Oakland", "San Rafael"]
    let calendar = Calendar.current
    
    mutating func generate_tickets(num: Int = 50) {
        for _ in 1...num {
            var usageDate = Date()
            var orderDate = Date()
            for x in 1...2 {
                var components = DateComponents()
                components.year = Int(randomNumber(inRange: 2015...2017))
                components.month = Int(randomNumber(inRange: 1...12))
                switch components.month! {
                case 2:
                    components.day = Int(randomNumber(inRange: 1...28))
                case 4, 6, 9, 11:
                    components.day = Int(randomNumber(inRange: 1...30))
                default:
                    components.day = Int(randomNumber(inRange: 1...31))
                }
                
                if x == 1 {
                    orderDate = calendar.date(from: components)!
                } else {
                    let month = components.month
                    let year = components.year
                    if monthYears.contains("\(month)\(year)") == false {
                        monthYears.append("\(month)\(year)")
                    }
                    components.hour = Int(randomNumber(inRange: 1...12))
                    components.minute = Int(randomNumber(inRange: 0...59))
                    usageDate = calendar.date(from: components)!
                }
            }
            
            let callOrderNo = "\(Int(randomNumber(inRange: 11111111...99999999)))"
            let firstName = "\(first_names[randomNumber(inRange: 0...first_names.count-1)])"
            let lastName = "\(last_names[randomNumber(inRange: 0...last_names.count-1)])"
            let ticketNo = Int(randomNumber(inRange: 11111111...99999999))
            let bpaNo = "\(Int(randomNumber(inRange: 1111...9999)))"
            let can = 1234
            let hearingSite = "\(sites[randomNumber(inRange: 0...sites.count-1)])"
            let vendorTin = "12345"
            let soc = "1234"
            let rate = 60.00
            let onTheRecord = true
            let fileType = Ticket.FileType.Digital
            
            tickets.append(Ticket(orderDate: orderDate, callOrderNo: callOrderNo, claimantFirstName: firstName, claimantLastName: lastName, ticketNo: ticketNo, bpaNo: bpaNo, can: can, hearingSite: hearingSite, vendorTin: vendorTin, soc: soc, usageDate: usageDate, rate: rate, onTheRecord: onTheRecord, fileType: fileType))
        }
    }
    
    func ticketsByMonthYear(month:Int, year: Int) -> [Ticket] {
        // Get an array of tickets for the month and year specified.
        let calendar = Calendar.current
        let monthYear = "\(month)\(year)"
        var ticketsForMonthYear = [Ticket]()
        
        if monthYears.contains(monthYear) {
            for ticket in tickets {
                let usageMonth = calendar.component(.month, from: ticket.usageDate!)
                let usageYear = calendar.component(.year, from: ticket.usageDate!)
                let key = "\(usageMonth)\(usageYear)"
                if key == monthYear {
                    ticketsForMonthYear.append(ticket)
                }
            }
        }
        return ticketsForMonthYear
    }
}
