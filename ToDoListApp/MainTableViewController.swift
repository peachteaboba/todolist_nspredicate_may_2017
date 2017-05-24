//
//  MainTableViewController.swift
//  ToDoListApp
//
//  Created by Andy Feng on 4/11/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, ReloadTVDelegate {

    
    // Global Variables ::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemsArr = [Item]()
    
    
    // UI Lifecycle ::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getAllData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // Core Data Methods :::::::::::::::::::::::::::::::::::
    func getAllData() {
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        
//        let checkedPredicate = NSPredicate(format: "checked == false")

//        itemRequest.predicate = checkedPredicate
        
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        
        itemRequest.sortDescriptors = [dateSortDescriptor]
        
        do {
            // Get the results by executing the fetch request we made earlier
            let results = try context.fetch(itemRequest)
            
            // Downcast the results as an array of Item objects
            itemsArr = results as! [Item]
            
            // Reload data
            tableView.reloadData()
            
        } catch {
            // Print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
    }
    
    
    
    
    // Table View Methods ::::::::::::::::::::::::::::::::::
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomItemCell
        
        cell.model = itemsArr[indexPath.row]
        
        return cell
    }
    
    
    // Other Protocol Methods ::::::::::::::::::::::::::::::
    func reloadTV() {
        getAllData()
    }
    
    
    // Prepare for Sugue :::::::::::::::::::::::::::::::::::
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! AddItemViewController
        vc.reloadTVDelegate = self
 
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
             
                
                
                /// Edit Checked Property
                let thisItem = itemsArr[indexPath.row]
                thisItem.checked = false
                
                
                
                
            } else {
                cell.accessoryType = .checkmark
                
                /// Edit Checked Property
                let thisItem = itemsArr[indexPath.row]
                thisItem.checked = true
                
      
            }
            
            
            /// Save to Core Data
            if context.hasChanges {
                do {
                    try context.save()
                    print("Success")
                } catch {
                    print("\(error)")
                }
            }
        }
    }
    
    
    
    
    
}















