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

    override func viewDidLoad() {
        super.viewDidLoad()

        data = DataController()
        tickets = data?.tickets
        
        let ticket = Ticket(orderDate: Date(), callOrderNo: "12345678", claimantFirstName: "Adrian", claimantLastName: "Chambers", ticketNo: 12345678, bpaNo: "1234", can: 1234, hearingSite: "Sacramento", vendorTin: "12345", soc: "1234", usageDate: Date(), usageTime: Date(), rate: 60.00, onTheRecord: true, fileType: .Digital)
        
        tickets?.append(ticket)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

                }
            }
        }
    }
}

// MARK: - Table view data source

extension TicketTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = tickets {
            return tickets!.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticket", for: indexPath) as! TicketTableViewCell
        if let ticket = tickets?[indexPath.row] {
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
                cell.date.text = usageDate.toString(format: "MMM d, h:mm a")
            } else {
                cell.date.text = "No Date"
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
