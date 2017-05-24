//
//  AddItemViewController.swift
//  ToDoListApp
//
//  Created by Andy Feng on 4/11/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//
import UIKit
import CoreData

class AddItemViewController: UIViewController {
    
    // Global Variables ::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var reloadTVDelegate: ReloadTVDelegate?
    
    
    // Outlets ::::::::::::::::::::::::::::::::::::::::::::
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    
    
    
    @IBAction func handleCancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleAddItemButtonPressed(_ sender: UIButton) {
        /// Create the Item Entity
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
        newItem.name = nameField.text
        newItem.desc = descField.text
        newItem.date = myDatePicker.date as NSDate
        newItem.checked = false
        
        
        
        /// Save to Core Data
        if context.hasChanges {
            do {
                try context.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        
        
        
        /// Dismiss and reload Table View
        dismiss(animated: true, completion: nil)
        reloadTVDelegate?.reloadTV()
        
        
        
        
    }

    // UI Lifecycle ::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
