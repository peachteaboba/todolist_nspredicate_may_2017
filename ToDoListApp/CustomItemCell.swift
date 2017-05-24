//
//  CustomItemCell.swift
//  ToDoListApp
//
//  Created by Andy Feng on 4/11/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit

class CustomItemCell: UITableViewCell {

    // Variables ::::::::::::::::::::::
    
    
    
    // Outlets ::::::::::::::::::::::::
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    
    
    // Model ::::::::::::::::::::::::::
    private var _model:Item?
    
    var model:Item {
        set {
            _model = newValue
            
            // Do Stuff
            doStuff()
        }
        get {
            return _model!
        }
    }
    
    
    // Cell Methods :::::::::::::::::::
    func doStuff() {
        
        // Set text
        nameLabel.text = _model?.name
        descLabel.text = _model?.desc
        
        // Set date
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .short
        dateLabel.text = myFormatter.string(from: (_model?.date)! as Date)
        
        // Set checkmark
        if (_model?.checked)! {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
        
    }
    
    
    
}
