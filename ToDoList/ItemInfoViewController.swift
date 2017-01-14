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
    
    @IBOutlet weak var timeCreated: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var timeCompleted: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = selectedItem {
            navigationBar.title = item.itemDescription
            timeCreated.text = "Time Created: " + item.formatTime(time: item.timeCreated!)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}