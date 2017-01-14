//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/14/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: properties
    @IBOutlet weak var newItemTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    // create a new To Do Item
    var toDoItem: ToDoItem?
    

    //MARK: generic functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let currentTime = NSDate()
        timeCreated.text = formatTime(time: currentTime) */
        updateSaveButton()
        // Do any additional setup after loading the view.
    }
    
    /*public func formatTime(time: NSDate) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: time as Date)
        
    }*/ 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: private functions
    // enable SaveButton if textField isn't empty
    private func updateSaveButton() {
        let text = newItemTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: UITextFieldDelegate Functions
    // Hides the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // allow the save button
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
    }
    
    // disables saving when editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }

    
    // MARK: - Navigation
    // Cancel unwind segue
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Configure the new To Do List once save item
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let button = sender as? UIBarButtonItem, button == saveButton {
            let itemDescription = newItemTextField.text ?? ""
            let completed = false
            toDoItem = ToDoItem(completed: completed, itemDescription: itemDescription, timeCreated: NSDate(), timeCompleted: nil)
           
            
           
            
            
            
        }
        else {
            fatalError("wrong button!! Not save button")
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
 
}
