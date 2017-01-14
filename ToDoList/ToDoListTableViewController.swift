//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/12/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController, UITextFieldDelegate {
    
    // todo list items
    var toDoItems = [ToDoItem] ()
    
    
    // MARK: private functions
    private func loadItems() {
        // sample items for testing
        
        
        if let item1 = ToDoItem(completed: false, itemDescription: "finish project", timeCreated: NSDate(), timeCompleted: nil) {
            toDoItems.append(item1)
        }
        
    }
    
    
    // blue - completed, white - not completed!
    // Toggles button color and updates appropriate ToDoItem's properties
    @IBAction private func toggleItem(_ sender: UIButton) {
        
        if sender.backgroundColor != UIColor.blue {
            sender.backgroundColor = UIColor.blue
            toDoItems[sender.tag].completed = true
            toDoItems[sender.tag].timeCompleted = NSDate()
            
        }
        else {
            sender.backgroundColor = UIColor.white
            toDoItems[sender.tag].completed = false
            toDoItems[sender.tag].timeCompleted = nil
        }
        
    }
    
    // MARK: actions
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddItemViewController, let newItem = sourceViewController.toDoItem {
            // add the new Item to the list on the screen
            let newIndexPath = IndexPath(row: toDoItems.count, section: 0)
            toDoItems.append(newItem)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    // update items array after finish cell
    @IBAction func updateItem(_ sender: UITextField) {
        toDoItems[sender.tag].itemDescription = sender.text
        
    }
    
    //MARK: generic functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if section == 0  {
            return toDoItems.count
        }
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // already created to do list items
        if indexPath.section == 0 {
            // display each to do list item
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoItemTableViewCell {
                
                // gets correct item from toDoItems array
                let item = toDoItems[indexPath.row]
                
                // configures cell appearance
                if item.completed {
                    cell.toggleButton.backgroundColor = UIColor.blue
                    print("should be blue")
                }
                cell.itemDescription.text = item.itemDescription
                
                // sets tags to connect cell with appropriate element in items array
                cell.toggleButton.tag = indexPath.row
                cell.itemDescription.tag = indexPath.row
                
                
                return cell
                
            }
            else {
                fatalError("Failed to correctly display ToDoItemCells")
            }
            
        }
            // ignore - earlier version
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath) as? EmptyItemTableViewCell {
                // configures empty cell
                cell.emptyDescription.text = nil
                return cell
                
            }
            else {
                fatalError("Failed to correctly display Empty cell!")
                
            }
            
        }
        
        
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
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
    
    
    // MARK: - Navigation
    
    // ID which To Do item has been selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let identifier = segue.identifier ?? ""
        print(identifier)
        switch (identifier) {
        case "addItem": print("add item!!")
        case "itemInfo":
            if let itemDetailInfoViewController = segue.destination as? ItemInfoViewController {

                // find the corresponding table Cell for the info button
                if let buttonPressed = sender as? UIButton{
                    let selectedItem = toDoItems[buttonPressed.tag]
                    itemDetailInfoViewController.selectedItem = selectedItem
                
                }
                else {
                    fatalError("not a TableViewCell")
                }
            }
            else {
                fatalError("\(segue.destination)")
                //fatalError("wrong segue Destination")
            }
        default: print("not matching!")
        }
        

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
