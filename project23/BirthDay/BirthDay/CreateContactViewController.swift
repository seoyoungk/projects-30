//
//  CreateContactViewController.swift
//  BirthDay
//
//  Created by Seoyoung on 29/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import Contacts

class CreateContactViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(CreateContactViewController.createContact))
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func createContact() {
        let newContact = CNMutableContact()
        
        newContact.givenName = firstName.text!
        newContact.familyName = lastName.text!
        
        if let homeEmail = email.text {
            let homeEmail = CNLabeledValue(label: CNLabelHome, value: homeEmail as NSString)
            newContact.emailAddresses = [homeEmail]
        }
        
        let birthdayComponents = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: datePicker.date)
        newContact.birthday = birthdayComponents
        
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.add(newContact, toContainerWithIdentifier: nil)
            try AppDelegate.appDelegate.contactStore.execute(saveRequest)
            
            navigationController?.popViewController(animated: true)
        } catch {
            Helper.show(message: "Unable to save the new contact.")
        }
    }
    
}
