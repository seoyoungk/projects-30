//
//  DetailViewController.swift
//  TodoList
//
//  Created by Seoyoung on 20/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var todo: TodoItem?
    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    @IBOutlet weak var todoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            self.title = "Edit Todo"
            if todo.image == "child-selected"{
                childButton.isSelected = true
            }
            else if todo.image == "phone-selected"{
                phoneButton.isSelected = true
            }
            else if todo.image == "shopping-cart-selected"{
                shoppingButton.isSelected = true
            }
            else if todo.image == "travel-selected"{
                travelButton.isSelected = true
            }
            
            todoTextField.text = todo.title
            todoDatePicker.setDate(todo.date, animated: false)
        } else {
            title = "New Todo"
            childButton.isSelected = true
        }
    }
    
    @IBAction func selectChild(_ sender: AnyObject) {
        resetButton()
        childButton.isSelected = true
    }
    
    @IBAction func selectPhone(_ sender: AnyObject) {
        resetButton()
        phoneButton.isSelected = true
    }
    
    @IBAction func selectShopping(_ sender: AnyObject) {
        resetButton()
        shoppingButton.isSelected = true
    }

    @IBAction func selectTravel(_ sender: AnyObject) {
        resetButton()
        travelButton.isSelected = true
    }
    
    func resetButton(){
        childButton.isSelected = false
        phoneButton.isSelected = false
        shoppingButton.isSelected = false
        travelButton.isSelected = false
    }
    
    @IBAction func tapDone(_ sender: AnyObject) {
        var image = ""
        if childButton.isSelected {
            image = "child-selected"
        } else if phoneButton.isSelected {
            image = "phone-selected"
        } else if shoppingButton.isSelected {
            image = "shopping-cart-selected"
        } else if travelButton.isSelected {
            image = "travel-selected"
        }
        if let todo = todo {
            todo.image = image
            todo.title = todoTextField.text!
            todo.date = todoDatePicker.date
        } else {
            let uuid = UUID().uuidString
            todo = TodoItem(id: uuid, title: todoTextField.text!, date: todoDatePicker.date, image: image)
            todos.append(todo!)
        }
         let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
