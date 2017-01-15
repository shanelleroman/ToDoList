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
            
           /* for _ in 0 ... 30 {
                toDoItems.append(item1)
            } */
        }
        

    }
    
    
    // blue - completed, white - not completed!
    // Toggles button color and updates appropriate ToDoItem's properties
    @IBAction private func toggleItem(_ sender: UIButton) {
        
        // change to complete
        if sender.backgroundColor != UIColor.blue {
            // update object
            toDoItems[sender.tag].completed = true
            toDoItems[sender.tag].timeCompleted = NSDate()
            
            // update color of cell
            sender.backgroundColor = UIColor.blue
            let indexPath = IndexPath(row: sender.tag, section: 0)
            if let selectedCell = tableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell {
                selectedCell.itemDescription.textColor = UIColor.gray
                selectedCell.itemDescription.isUserInteractionEnabled = false
            }
            
            
            
            
        }
        else {
            sender.backgroundColor = UIColor.white
            toDoItems[sender.tag].completed = false
            toDoItems[sender.tag].timeCompleted = nil
            
            // change color back
            let indexPath = IndexPath(row: sender.tag, section: 0)
            if let selectedCell = tableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell {
                selectedCell.itemDescription.textColor = UIColor.black
                selectedCell.itemDescription.isUserInteractionEnabled = false
            }
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
        toDoItems.sort(by: {$0.completed && !$1.completed })
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
        // return the number of rows
        if section == 0  {
            return toDoItems.count
        }
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
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
            cell.moreInformation.tag = indexPath.row
            print("tag: \(indexPath.row) for \(cell.itemDescription)")
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            
            return cell
            
        }
        else {
            fatalError("Failed to correctly display ToDoItemCells")
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
    
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        
     
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
        print(identifier)
        switch (identifier) {
        case "addItem": print("add item!!")
        case "itemInfo":
            if let itemDetailInfoViewController = segue.destination as? ItemInfoViewController {
                
                // find the corresponding table Cell for the info button
                if let buttonPressed = sender as? UIButton{
                    print("button Pressed tag: \(buttonPressed.tag)")
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
        
    }
    
    
}
