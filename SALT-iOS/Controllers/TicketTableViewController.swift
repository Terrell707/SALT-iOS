//
//  TicketTableViewController.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 2/26/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import UIKit

class TicketTableViewController: UITableViewController {

    var data: DataController?
    var tickets: [Ticket]?
    var years: [Int]?

    override func viewDidLoad() {
        super.viewDidLoad()

        data = DataController()
        data?.generate_tickets()
        tickets = data!.tickets
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ticketsByDate(tickets: [Ticket]) -> [Date: [Ticket]] {
        // Sort the tickets by date so we can display them correctly.
        let sortedTickets = tickets.sorted(by: { $0.usageDate! > $1.usageDate! })
        
        let calendar = Calendar.current
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.current
//        dateFormatter.timeZone = calendar.timeZone
//        dateFormatter.dateFormat = "MMMM YYYY"
        
        // Used to keep track of the current year and month.
        var previousYear = -1
        var previousMonth = -1
        var sectionDate: Date?
    
        // Represent how tickets will be laid out in the table.
        var ticketTable = [Date: [Ticket]]()
        
        for ticket in sortedTickets {
            let components = calendar.dateComponents([.year, .month], from: ticket.usageDate!)
            let year = components.year
            let month = components.month
            if (year != previousYear || month != previousMonth) {
                // Create the section heading.
                sectionDate = calendar.date(from: components)
                // Create an array of tickets for the new section heading.
                ticketTable[sectionDate!] = [Ticket]()
                previousYear = year!
                previousMonth = month!
            }
            if let section = sectionDate {
                ticketTable[section]!.append(ticket)
            } else {
                print("Missed a section because of missed date! \(sectionDate)")
            }
        }
        
        return ticketTable
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "ticketDetailSegue" {
                let selectedRow = self.tableView.indexPathForSelectedRow?.row
                if let ticket = tickets?[selectedRow!] {
                    let navVC = segue.destination as! UINavigationController
                    let ticketDetailVC = navVC.topViewController as! TicketDetailTableViewController
                    ticketDetailVC.ticket = ticket
                    print("Moving to Ticket Detail View")
                }
            } else if identifier == "ticketCreateSegue" {
                let navVC = segue.destination as! UINavigationController
                print("Moving to Create Ticket View")
            }
        }
    }
}

// MARK: - Table view data source

extension TicketTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = tickets {
            let ticketSections = self.ticketsByDate(tickets: tickets!)
            print("Ticket Sections: \(ticketSections.count)")
            return ticketSections.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let _ = tickets {
            // Get the tickets broken down by month and year.
            let ticketSections = self.ticketsByDate(tickets: tickets!)
            
            // Get the correct month/year from the list for the current section and format it into a string.
            let sectionDate = ticketSections.sortedKeysDescending[section]
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = Calendar.current.timeZone
            dateFormatter.dateFormat = "MMMM YYYY"
            let sectionTitle = dateFormatter.string(from: sectionDate)
            return sectionTitle
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = tickets {
            // Get the tickets broken down by month and year.
            let ticketSections = self.ticketsByDate(tickets: tickets!)
            
            // Get the correct set of tickets by the current section.
            let sectionDate = ticketSections.sortedKeysDescending[section]
            let ticketRows = ticketSections[sectionDate]
            if let rows = ticketRows {
                print("Rows: \(rows.count)")
                return rows.count
            }
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticket", for: indexPath) as! TicketTableViewCell
        if let _ = tickets {
            // Get the tickets broken down by month and year.
            let ticketSections = self.ticketsByDate(tickets: tickets!)
            
            // Get the correct section.
            let sectionDate = ticketSections.sortedKeysDescending[indexPath.section]
            
            // Get the correct set of tickets for the section.
            let ticketRows = ticketSections[sectionDate]
            
            // Get the correct ticket for the row.
            if let ticket = ticketRows?[indexPath.row] {
                // Formats the name and presents it in the cell.
                if  let lastName = ticket.claimantLastName,
                    let firstName = ticket.claimantFirstName {
                    cell.name.text = ("\(lastName), \(firstName)")
                } else if let name = ticket.claimantLastName {
                    cell.name.text = name
                } else if let name = ticket.claimantFirstName {
                    cell.name.text = name
                } else {
                    cell.name.text = "No Name"
                }
                
                // Formats the ticket number and presents it in the cell.
                if let ticketNumber = ticket.ticketNo {
                    cell.number.text = "\(ticketNumber)"
                } else {
                    cell.number.text = "No Ticket Number"
                }
                
                // Formats the date and presents it in the cell.
                if let usageDate = ticket.usageDate {
                    cell.date.text = usageDate.toString(format: "MMM d yyyy, h:mm a")
                } else {
                    cell.date.text = "No Date"
                }
            }
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
