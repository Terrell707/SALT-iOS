//
//  TicketCreateTableViewController.swift
//  SALT-iOS
//
//  Created by Adrian T. Chambers on 3/16/17.
//  Copyright © 2017 Adrian T. Chambers. All rights reserved.
//

import UIKit

class TicketCreateTableViewController: UITableViewController, UITextFieldDelegate {

    // Used to store the text that the user enters for each field.
    var ticketFields: [Int: String]?
    // Used to populate each text field with the details of a ticket.
    var ticketToEdit: Ticket?
    // Used to keep track of the active textfield in case user clicks "Save"
    //  while a field is being editted.
    var activeTextfield: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hides the seperators between cells.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Populate each field with info from the passed in ticket. Otherwise, start fresh.
        if let ticket = ticketToEdit {
            
        } else {
            ticketFields = [Int: String]()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Makes it so that each text view adds the delegate.
        for cell in self.tableView.visibleCells {
            for sub in cell.contentView.subviews {
                if let sub = sub as? UITextField {
                    print("Textfield: \(sub.placeholder ?? "No Placeholder Text")")
                    sub.delegate = self
                }
            }
        }
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
    
    @IBAction func saveTicket(_ sender: UIBarButtonItem) {
        // Check to see if user is currently editing a field. If so, grab the text from it.
        if let activeField = activeTextfield {
            // Add the text to the dictionary.
            if ticketFields != nil {
                ticketFields?[activeField.tag] = activeField.text!
            } else {
                ticketFields = [Int: String]()
                ticketFields?[activeField.tag] = activeField.text!
            }
        }
        
        // Go through each field in the table.
        if let fields = ticketFields {
            let fieldTags = TicketTextFieldTags.self
            var newTicket = Ticket()
            newTicket.ticketNo = Int(fields[fieldTags.TicketNumber.rawValue]!)
            newTicket.claimantFirstName = fields[fieldTags.ClaimantFirstName.rawValue]
            newTicket.claimantLastName = fields[fieldTags.ClaimantLastName.rawValue]
            newTicket.usageDate = fields[fieldTags.HearingDate.rawValue]?.toDate()
            newTicket.orderDate = fields[fieldTags.OrderDate.rawValue]?.toDate()
            newTicket.callOrderNo = fields[fieldTags.CallOrderNumber.rawValue]
            newTicket.bpaNo = fields[fieldTags.BPANumber.rawValue]!
            newTicket.can = Int(fields[fieldTags.CAN.rawValue]!)
            newTicket.vendorTin = fields[fieldTags.VendorTIN.rawValue]
            newTicket.soc = fields[fieldTags.SOC.rawValue]
            newTicket.rate = Double(60.00)
            newTicket.onTheRecord = true
            newTicket.fileType = Ticket.FileType.Digital
            
            // Hearing Information
            let office = Office(code: fields[fieldTags.OfficeCode.rawValue], name: fields[fieldTags.OfficeName.rawValue])
            let judge = Judge(firstName: fields[fieldTags.JudgeFirstName.rawValue], lastName: fields[fieldTags.JudgeLastName.rawValue], office: office, active: true)
            let rep = Expert(firstName: fields[fieldTags.RepFirstName.rawValue], lastName: fields[fieldTags.RepLastName.rawValue], role: Expert.Role.Representative)
            let vocational = Expert(firstName: fields[fieldTags.VocationalFirstName.rawValue], lastName: fields[fieldTags.VocationalLastName.rawValue], role: Expert.Role.Vocational)
            let medical1 = Expert(firstName: fields[fieldTags.MedicalFirstName.rawValue], lastName: fields[fieldTags.MedicalLastName.rawValue], role: Expert.Role.Medical)
            let interpreter = Expert(firstName: fields[fieldTags.Interpreter.rawValue], lastName: nil, role: Expert.Role.Interpreter)

            newTicket.hearingSite = office
            newTicket.judge = judge
            newTicket.representative = rep
            newTicket.vocational = vocational
            newTicket.medicals?.append(medical1)
            newTicket.interpreter = interpreter
        }
    }
    
    
    // MARK: - Table view data source

    /*
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
    */
    
    // MARK: - TextField Delegate functions
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing at: \(textField.tag)")
        
        // Add the text to the dictionary.
        if ticketFields != nil {
            ticketFields?[textField.tag] = textField.text!
        } else {
            ticketFields = [Int: String]()
            ticketFields?[textField.tag] = textField.text!
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Save the active textfield so we can get the text from it if user clicks "Save".
        activeTextfield = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // Remove the active textfield.
        activeTextfield = nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
