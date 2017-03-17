//
//  TicketDetailTableViewController.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 2/26/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import UIKit

class TicketDetailTableViewController: UITableViewController {

    // The ticket in which we'll show the info for.
    var ticket: Ticket?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Hides the seperators between cells.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(ticket?.ticketNo!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
}

// MARK: - Table view data source

extension TicketDetailTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10
        case 1:
            // TODO: Need to return the correct number later.
            return 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Ticket Information"
        case 1:
            return "Hearing Information"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketDetail", for: indexPath)
        let selection = (indexPath.section, indexPath.row)
        var text: String = "None"
        var color: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        switch selection {
        case (0, 0):
            cell.textLabel?.text = "Ticket Number:"
            (text, color) = formatForCell(property: ticket?.ticketNo)
        case (0, 1):
            cell.textLabel?.text = "First Name:"
            (text, color) = formatForCell(property: ticket?.claimantFirstName)
        case (0, 2):
            cell.textLabel?.text = "Last Name:"
            (text, color) = formatForCell(property: ticket?.claimantLastName)
        case (0, 3):
            cell.textLabel?.text = "Order Date:"
            (text, color) = formatForCell(property: ticket?.orderDate)
        case (0, 4):
            cell.textLabel?.text = "Call Order No:"
            (text, color) = formatForCell(property: ticket?.callOrderNo)
        case (0, 5):
            cell.textLabel?.text = "BPA No:"
            (text, color) = formatForCell(property: ticket?.bpaNo)
        case (0, 6):
            cell.textLabel?.text = "CAN:"
            (text, color) = formatForCell(property: ticket?.can)
        case (0, 7):
            cell.textLabel?.text = "Vendor TIN:"
            (text, color) = formatForCell(property: ticket?.vendorTin)
        case (0, 8):
            cell.textLabel?.text = "SOC:"
            (text, color) = formatForCell(property: ticket?.soc)
        case (0, 9):
            cell.textLabel?.text = "Rate:"
            (text, color) = formatForCell(property: ticket?.rate)
        default:
            cell.textLabel?.text = "None"
            cell.detailTextLabel?.text = "None"
        }
        
        cell.detailTextLabel?.text = text
        cell.detailTextLabel?.textColor = color
        
        return cell
    }
    
    func formatForCell(property: Any?) -> (String, UIColor) {
        let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let noneTextColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if let prop = property {
            if prop is Date {
                return ((prop as! Date).toString(), textColor)
            }
            else if prop is Int {
                return ("\(prop)", textColor)
            }
            else if prop is Double {
                return ((prop as! Double).toUSD(), textColor)
            }
            else if prop is String {
                return (prop as! String, textColor)
            }
            else {
                return (prop as! String, textColor)
            }
        } else {
            return ("None", noneTextColor)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
