//
//  DataController.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 2/26/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import Foundation

// Used to get the tag of each textfield in the Create Ticket View Controller.
//  The tags are defined per textfield in the Storyboard.
enum TicketTextFieldTags: Int {
    case TicketNumber = 0
    case ClaimantFirstName = 4
    case ClaimantLastName = 8
    case HearingDate = 12
    case OrderDate = 16
    case CallOrderNumber = 20
    case BPANumber = 24
    case CAN = 28
    case VendorTIN = 32
    case SOC = 36
    case OnTheRecord = 40
    case FileType = 44
    case OfficeCode = 48
    case OfficeName = 52
    case JudgeFirstName = 56
    case JudgeLastName = 60
    case RepFirstName = 64
    case RepLastName = 68
    case VocationalFirstName = 72
    case VocationalLastName = 76
    case MedicalFirstName = 80
    case MedicalLastName = 84
    case Medical2FirstName = 88
    case Medical2LastName = 92
    case Medical3FirstName = 96
    case Medical3LastName = 100
    case Interpreter = 104
}

// Used to get the data from the server.
struct DataController {
    var tickets = [Ticket]()
    var monthYears = [String]()
    
    // Used to generate Sample Ticket Data
    let firstNames = ["Adrian", "Joesph", "Talanda", "Alama", "Justin", "Jessica", "Christope", "Chris", "Tammy",
                       "Lucy", "Leo", "Barbara", "Patrick", "Tamar", "Crissle", "Derek", "Lyndsay", "Jonathan",
                       "Mandy", "Amanda", "Kenan", "Lakshmi", "Alex", "Marlon", "Jenika", "Tenika", "David",
                       "Sarah", "Jessica", "Robert", "James", "Gary", "Steve"]
    let lastNames = ["Sullivan", "Williams", "Sao", "Orme", "Lee", "Ravel", "Toyo", "Jamar", "Saldana",
                     "Martinez", "Smith", "Park", "Bounds", "Chambers", "Davis", "Totah", "Entzel", "Blume",
                     "Eckerson", "Gillis", "Tronvig", "Villerie", "Downey", "Drumwright", "Creighton-Cravel",
                     "Giffin", "Rafkind"]
    let sites = ["Sacramento", "San Jose", "Oakland", "San Rafael"]

    
    // Used to get the user's locale
    let calendar = Calendar.current
    
    mutating func generateTickets(num: Int = 50) {
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
            let firstName = "\(firstNames[randomNumber(inRange: 0...firstNames.count-1)])"
            let lastName = "\(lastNames[randomNumber(inRange: 0...lastNames.count-1)])"
            let ticketNo = Int(randomNumber(inRange: 11111111...99999999))
            let bpaNo = "\(Int(randomNumber(inRange: 1111...9999)))"
            let can = 1234
            let hearingSiteName = "\(sites[randomNumber(inRange: 0...sites.count-1)])"
            let office = Office(name: hearingSiteName)
            let vendorTin = "12345"
            let soc = "1234"
            let rate = 60.00
            let onTheRecord = true
            let fileType = Ticket.FileType.Digital
            
            var medicalExperts = [Expert]()
            for _ in 0...randomNumber(inRange: 0...2){
                medicalExperts.append(generateExpert(role: Expert.Role.Medical))
            }
            
            tickets.append(Ticket(ticketNo: ticketNo, firstName: firstName, lastName: lastName, orderDate: orderDate, callOrderNo: callOrderNo, bpaNo: bpaNo, can: can, vendorTin: vendorTin, soc: soc, usageDate: usageDate, rate: rate, onTheRecord: onTheRecord, fileType: fileType, hearingSite: office, judge: generateJudge(), representative: generateExpert(role: Expert.Role.Representative), vocational: generateExpert(role: Expert.Role.Vocational), medicals: medicalExperts, interpreter: nil))
        }
    }
    
    func generateJudge() -> Judge {
        let firstName = "\(firstNames[randomNumber(inRange: 0...firstNames.count-1)])"
        let lastName = "\(lastNames[randomNumber(inRange: 0...lastNames.count-1)])"
        let office = generateOffice()
        
        return Judge(firstName: firstName, lastName: lastName, office: office, active: true)
    }
    
    func generateOffice() -> Office {
        let codes = ["X84", "X95", "X43"]
        let names = ["X84": "Sacramento", "X95": "San Jose", "X43": "Oakland"]
        let code = "\(codes[randomNumber(inRange: 0...codes.count-1)])"
        let address = Address(street: "1234 Test Blvd", street2: "Suite 203", city: "Sacramento", state: "CA", zip: "91234")
        return Office(code: code, name: names[code], address: address, phoneNumber: "(123)456-7890", email: "testemail@ssa.com", can: "1234", pay: 60.00)
    }
    
    func generateExpert(role: Expert.Role) -> Expert {
        let firstName = firstNames[randomNumber(inRange: 0...firstNames.count-1)]
        let lastName = lastNames[randomNumber(inRange: 0...lastNames.count-1)]
        
        return Expert(firstName: firstName, lastName: lastName, role: role)
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
