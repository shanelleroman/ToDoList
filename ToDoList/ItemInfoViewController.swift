//
//  ItemInfoViewController.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/14/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import UIKit

class ItemInfoViewController: UIViewController {
    
    //MARK: properties
    var selectedItem: ToDoItem?
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var timeCreated: UILabel!
    @IBOutlet weak var timeCompleted: UILabel!
    @IBOutlet weak var priorityControl: UISegmentedControl!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = selectedItem {
            // title
            navigationBar.title = "Individual To Do"
            
            itemDescription.text = item.itemDescription
            itemDescription.layer.borderWidth = 1
            itemDescription.layer.cornerRadius = 10
            itemDescription.layer.borderColor = UIColor.black.cgColor
            timeCreated.text = "Time Created: " + item.formatTime(time: item.timeCreated!)
            priorityControl.selectedSegmentIndex = (selectedItem?.priority)!
            if item.completed {
                timeCompleted.text = "Time Completed: " +  item.formatTime(time: item.timeCompleted!)
            }
            else {
                timeCompleted.text = "Not yet completed"
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changedPriority(_ sender: UISegmentedControl) {
        selectedItem?.priority = sender.selectedSegmentIndex
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
