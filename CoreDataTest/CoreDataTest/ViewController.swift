//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Rohith Sriram on 8/16/20.
//  Copyright © 2020 Rohith Sriram. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBAction func createPressed(_ sender: UIButton) {
        create()
    }
    
    @IBAction func retrievePressed(_ sender: Any) {
        retrieve()
    }
    
    @IBAction func updatePressed(_ sender: UIButton) {
        update()
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        delete()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func create() {
        
        // Getting app delegate object
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // Create a managed context object
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Get table name
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)!
        
        // Create attribute (Row)
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set value to row
        person.setValue("Rohith", forKeyPath: "name")
        person.setValue("iOS Container", forKey: "journey")
        person.setValue(24, forKey: "age")
        
        // Save to table
        do {
            try managedContext.save()
            print("created successfully")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieve() {
        // Getting app delegate object
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // Create a managed context object
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Select the table to retrieve data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        
        //
        do {
            let databaseObject = try managedContext.fetch(fetchRequest)
            let employeeEntity = databaseObject[0]
            print(employeeEntity.value(forKey: "name") as Any)
            print(employeeEntity.value(forKey: "journey") as Any)
            print(employeeEntity.value(forKey: "age") as Any)
            
        } catch let error as NSError {
          print("Could not retrieve. \(error), \(error.userInfo)")
        }
    }
    
    func update() {
        // Getting app delegate object
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // Create a managed context object
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Select the table to retrieve data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")

        // Save to table
        do {
            let tableValues = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = tableValues[0]
            objectUpdate.setValue("Dashboard", forKey: "journey")
    
            try managedContext.save()
            print("Updated succesfully")
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    func delete() {
        
        // Getting app delegate object
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // Create a managed context object
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Select the table to retrieve data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        
        // Save to table
        do {
            let tableValues = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = tableValues[0]
            managedContext.delete(objectUpdate)
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }

    }
}
