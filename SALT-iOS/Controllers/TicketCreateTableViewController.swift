//
//  TicketCreateTableViewController.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/16/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import UIKit

class TicketCreateTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hides the seperators between cells.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        // Create an alert to let the user know they will lose unsaved changes.
        let alert = UIAlertController(title: "Cancel",
                                      message: "You have unsaved changes. Do you really want to cancel?",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        // Create the actions to dismiss or stay in the current view.
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.cancel) {
            (result : UIAlertAction) -> Void in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil)
        
        // Add the actions and present the alert.
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
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
    */

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
