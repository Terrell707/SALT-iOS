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
        print("Ticket Number: \(ticket?.ticketNo! ?? 00000000)")
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
            return 11
        case 1:
            return 7
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
            cell.textLabel?.text = "Hearing Date:"
            (text, color) = formatForCell(property: ticket?.usageDate)
        case (0, 4):
            cell.textLabel?.text = "Order Date:"
            (text, color) = formatForCell(property: ticket?.orderDate)
        case (0, 5):
            cell.textLabel?.text = "Call Order No:"
            (text, color) = formatForCell(property: ticket?.callOrderNo)
        case (0, 6):
            cell.textLabel?.text = "BPA No:"
            (text, color) = formatForCell(property: ticket?.bpaNo)
        case (0, 7):
            cell.textLabel?.text = "CAN:"
            (text, color) = formatForCell(property: ticket?.can)
        case (0, 8):
            cell.textLabel?.text = "Vendor TIN:"
            (text, color) = formatForCell(property: ticket?.vendorTin)
        case (0, 9):
            cell.textLabel?.text = "SOC:"
            (text, color) = formatForCell(property: ticket?.soc)
        case (0, 10):
            cell.textLabel?.text = "Rate:"
            (text, color) = formatForCell(property: ticket?.rate)
        case (1, 0):
            cell.textLabel?.text = "On the Record:"
            (text, color) = formatForCell(property: ticket?.onTheRecord)
        case (1, 1):
            cell.textLabel?.text = "File Type:"
            (text, color) = formatForCell(property: ticket?.fileType)
        case (1, 2):
            cell.textLabel?.text = "Judge:"
            (text, color) = formatForCell(property: ticket?.judge)
        case (1, 3):
            cell.textLabel?.text = "Representative:"
            (text, color) = formatForCell(property: ticket?.representative)
        case (1, 4):
            cell.textLabel?.text = "Vocational Expert:"
            (text, color) = formatForCell(property: ticket?.vocational)
        case (1, 5):
            cell.textLabel?.text = "Medical Experts:"
            (text, color) = formatForCell(property: ticket?.medicals)
        case (1, 6):
            cell.textLabel?.text = "Interpreter:"
            (text, color) = formatForCell(property: ticket?.interpreter)
        default:
            cell.textLabel?.text = "None"
            cell.detailTextLabel?.text = "None"
        }
        
        cell.detailTextLabel?.text = text
        cell.detailTextLabel?.textColor = color
        
        return cell
    }
    
    // Formats the detail text for a cell based on the type of property 
    //  passed in.
    func formatForCell(property: Any?) -> (String, UIColor) {
        let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let noneTextColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if let prop = property {
            // Format the date to string.
            if prop is Date {
                return ((prop as! Date).toString()!, textColor)
            }
            // Convert int to string.
            else if prop is Int {
                return ("\(prop)", textColor)
            }
            // Convert double to string.
            else if prop is Double {
                return ((prop as! Double).toUSD(), textColor)
            }
            // Just return the string.
            else if prop is String {
                return (prop as! String, textColor)
            }
            // Convert Boolean to Yes or No
            else if prop is Bool {
                var result: String
                let boolean = prop as! Bool
                if boolean {
                    result = "Yes"
                } else {
                    result = "No"
                }
                return (result, textColor)
            }
            // Convert the Ticket FileType Enum to string.
            else if prop is Ticket.FileType {
                return ("\(prop as! Ticket.FileType)", textColor)
            }
            // Convert the list of expert names into a multiline string.
            else if prop is [Expert] {
                let experts = prop as! [Expert]
                var expertString = ""
                var firstRun = true
                for expert in experts {
                    // Append a newline only if we aren't on the first run.
                    if firstRun == false {
                        expertString += "\n"
                    } else {
                        firstRun = false
                    }
                    
                    // Format the name and add it to the string.
                    expertString += getExpertName(expert: expert)

                    expertString += "\n"
                }
                return (expertString, textColor)
            }
            // Convert the expert name into a string.
            else if prop is Expert {
                return (getExpertName(expert: prop as? Expert), textColor)
            }
            // Conver the judge name into a string
            else if prop is Judge {
                return (getJudgeName(judge: prop as? Judge), textColor)
            }
            // Otherwise, just try and force a conversion to string.
            else {
                return (prop as! String, textColor)
            }
        } else {
            return ("None", noneTextColor)
        }
    }
    
    // Format the name for a expert.
    private func getExpertName(expert: Expert?) -> String {
        var expertString = ""
        
        // Format the names of experts.
        if  let firstName = expert?.firstName,
            let lastName = expert?.lastName {
            expertString += "\(lastName), \(firstName)"
        }
        else if let lastName = expert?.lastName {
            expertString += "\(lastName)"
        }
        else if let firstName = expert?.firstName {
            expertString += "\(firstName)"
        }
        else {
            expertString += "No Name"
        }
        
        return expertString
    }
    
    private func getJudgeName(judge: Judge?) -> String {
        var judgeString = ""
        
        // Format the names of experts.
        if  let firstName = judge?.firstName,
            let lastName = judge?.lastName {
            judgeString += "\(lastName), \(firstName)"
        }
        else if let lastName = judge?.lastName {
            judgeString += "\(lastName)"
        }
        else if let firstName = judge?.firstName {
            judgeString += "\(firstName)"
        }
        else {
            judgeString += "No Name"
        }
        
        return judgeString
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
