//
//  ToDoItemTableViewCell.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/12/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import UIKit

class ToDoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var moreInformation: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        toggleButton.backgroundColor = UIColor.white
        toggleButton.layer.cornerRadius = toggleButton.frame.height/2
        toggleButton.layer.borderWidth = 1
        toggleButton.layer.borderColor = UIColor.blue.cgColor
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
