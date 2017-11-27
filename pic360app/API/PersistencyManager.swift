//
//  PersistencyManager.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/12/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class PersistencyManager {
    private var propertyItems = [PropertyItem]()
    private var locations: [NSManagedObject] = []
    
    init() {
        
    }
    
    func getPropertyItemById(id: String) -> PropertyItem {
        var rv: PropertyItem! = nil
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return PropertyItem()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PropertyItem>(entityName: "PropertyItem")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            rv = try managedContext.fetch(fetchRequest)[0]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return rv
    }
    
    func getPropertyItems(location: String) -> [PropertyItem] {
        var rv: [PropertyItem]! = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PropertyItem>(entityName: "PropertyItem")
        fetchRequest.predicate = NSPredicate(format: "location == %@", location)
        
        do {
            rv = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return rv
    }
    
    func addPropertyItem(name: String, location: String, imgPath: String, description: String, serialNumber: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PropertyItem", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(UUID().uuidString, forKey: "id")
        item.setValue(name, forKeyPath: "name")
        item.setValue(description, forKeyPath: "desc")
        item.setValue(imgPath, forKeyPath: "imgName")
        item.setValue(location, forKeyPath: "location")
        item.setValue(serialNumber, forKeyPath: "serialNumber")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getLocations() -> [String] {
        var rv: [String]! = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")

        do {
            locations = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        for location in locations {
            rv.append(location.value(forKey: "name") as! String)
        }
        
        return rv
    }
    
    func saveLocation(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        let location = NSManagedObject(entity: entity, insertInto: managedContext)
        
        location.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteLocation(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            
            for item in fetchResults {
                managedContext.delete(item)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getLocationAmount(location: String) -> Int {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PropertyItem")
        fetchRequest.predicate = NSPredicate(format: "location == %@", location)
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            
            return fetchResults.count
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return 0
    }
}
