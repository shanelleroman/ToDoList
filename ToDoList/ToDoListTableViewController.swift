//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/12/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import UIKit
import os.log

class ToDoListTableViewController: UITableViewController, UITextFieldDelegate {
    
    // list of to do's
    var toDoItems = [ToDoItem] ()
    
    
    // MARK: private functions
    private func loadSampleItems() {
        if let item1 = ToDoItem(completed: false, itemDescription: "finish project", timeCreated: NSDate(), timeCompleted: nil, priority: 0) {
            toDoItems.append(item1)
            
        }
    }
    
    // load the archived items from before app was quit
    private func loadItems() -> [ToDoItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDoItem.ArchiveURL.path) as? [ToDoItem]
        
    }
    
    // archive the items
    private func saveItems() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDoItems, toFile: ToDoItem.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save ...", log: OSLog.default, type: .error)
        }
    }
    
    // get the cell row from the button pressed
    private func getCellRow(sender: UIButton) ->Int? {
        let pointInTable = sender.convert(sender.bounds.origin, to: self.tableView)
        if let cellIndexPath = self.tableView.indexPathForRow(at: pointInTable) {
            return cellIndexPath.row
        }
        return nil
        
        
    }
    
    
    // blue - completed, white - not completed!
    // Toggles button color and updates appropriate ToDoItem's properties
    @IBAction private func toggleItem(_ sender: UIButton) {
       
       
        // to do completed
        if sender.backgroundColor != UIColor.blue {
            
            // update item object
            if let index = getCellRow(sender: sender) {
                
                toDoItems[index].completed = true
                toDoItems[index].timeCompleted = NSDate()
                saveItems()
                
                // update color of cell
                sender.backgroundColor = UIColor.blue
                let indexPath = IndexPath(row: index, section: 0)
                if let selectedCell = tableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell {
                    selectedCell.itemDescription.textColor = UIColor.gray
                    selectedCell.itemDescription.isUserInteractionEnabled = false
                }
                
            }
            
            
        }
        else {
            sender.backgroundColor = UIColor.white
            if let index = getCellRow(sender: sender ) {
                // update item object
                toDoItems[index].completed = false
                toDoItems[index].timeCompleted = nil
                saveItems()
                // change color back
                let indexPath = IndexPath(row: index, section: 0)
                if let selectedCell = tableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell {
                    selectedCell.itemDescription.textColor = UIColor.black
                    selectedCell.itemDescription.isUserInteractionEnabled = false
                }
            }
            
        }
        
    }
    
    // MARK: actions
    // unwind from both ItemInfo and Add Item Info View Controller
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? AddItemViewController, let newItem = sourceViewController.toDoItem {
            // add the new Item to the list on the screen
            let newIndexPath = IndexPath(row: toDoItems.count, section: 0)

            toDoItems.append(newItem)
            // reloading because had issue with the button colors
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.reloadRows(at: [newIndexPath], with: .automatic)
            
        }
        else if let sourceViewController = sender.source as? ItemInfoViewController, let editedItem = sourceViewController.selectedItem, let index = sourceViewController.rowIndex{
            
            let cellIndexPath = IndexPath(item: index, section: 0)
            toDoItems[index] = editedItem
            tableView.reloadRows(at: [cellIndexPath], with: .none)
            
        }
        saveItems()
    }
    
    // update items array after finish editing a cell
    @IBAction func updateItem(_ sender: UITextField) {
        
        // get the correct cell
        var cell: UITableViewCell?
        var parentView = sender.superview
        while (parentView != nil) {
            if parentView is UITableViewCell {
                cell = parentView as! UITableViewCell?
                break
            }
            parentView = parentView?.superview
        }
        // update the correct item's description
        if (cell != nil) {
            let indexPath = self.tableView.indexPath(for: cell!)
            
            toDoItems[(indexPath?.row)!].itemDescription = sender.text
            
        }
        
        
        
    }
    
    //MARK: generic functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedItems = loadItems() {
            
            toDoItems += savedItems
        }
        else {
            
            loadSampleItems()
        }
        
        
        
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        /* let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add
         , target: self, action: "addItem")
         self.navigationItem.setRightBarButton(addButton, animated: false) */
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    
    /* func dismissKeyboard() {
     view.endEditing(true)
     } */
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell {
            selectedCell.contentView.backgroundColor = UIColor.clear
            selectedCell.itemDescription.isUserInteractionEnabled = true
            selectedCell.itemDescription.becomeFirstResponder()
            
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems.count
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // display each to do list item
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoItemTableViewCell {
            
            // gets correct item from toDoItems array
            let item = toDoItems[indexPath.row]
            
            // configures cell appearance
            if item.completed {
                cell.toggleButton.backgroundColor = UIColor.blue
                
            }
            else {
                cell.toggleButton.backgroundColor = UIColor.white
            }
            
            cell.itemDescription.text = item.itemDescription
            switch item.priority {
            case 0:
                cell.priorityLabel.text = ""
            case 1:
                cell.priorityLabel.text = "!"
                cell.priorityLabel.textColor = UIColor.red
            case 2:
                cell.priorityLabel.text = "!!"
                cell.priorityLabel.textColor = UIColor.red
            case 3:
                cell.priorityLabel.text = "!!!"
                cell.priorityLabel.textColor = UIColor.red
            default: cell.priorityLabel.text = ""
            }

            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            
            return cell
            
        }
        else {
        
            fatalError("Failed to correctly display ToDoItemCells.")        }
        
        
        
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveItems()
            
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let item = toDoItems[fromIndexPath.row];
        toDoItems.remove(at: fromIndexPath.row);
        toDoItems.insert(item, at: to.row)
        
        
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // ID which To Do item has been selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let identifier = segue.identifier ?? ""
        switch (identifier) {
        case "addItem": break
        case "itemInfo":
            // get access to the segue destination Navigation Controller
            if let itemInfoNavigationController = segue.destination as? UINavigationController{
                
                // access the detail view controller
                if let itemInfoDetailViewController = itemInfoNavigationController.topViewController as? ItemInfoViewController{
                    
                    // find the corresponding table Cell for the info button
                    if let buttonPressed = sender as? UIButton{
                        // get cell row
                        if let index = getCellRow(sender: buttonPressed) {
                            let selectedItem = toDoItems[index]
                            itemInfoDetailViewController.selectedItem = selectedItem
                            itemInfoDetailViewController.rowIndex = index
                            
                        }
                        else {
                            os_log("couldn't get cell row", log: OSLog.default, type: .error)
                            
                        }
                        
                    }
                    else {
                        os_log("sender isn't a UI button", log: OSLog.default, type: .error)
                        
                    }
                    
                    
                }
                else {
                    os_log("not a Table View Cell", log: OSLog.default, type: .error)

                
                }
            }
            else {
                os_log("Wrong segue destination", log: OSLog.default, type: .error)

            }
        default: break
        }
        
    }
    
    
}
