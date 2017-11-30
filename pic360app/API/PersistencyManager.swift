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
    
    func setImage(name: String, comment: String) -> Image {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return Image()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let imageEntity = NSEntityDescription.entity(forEntityName: "Image", in: managedContext)!
        
        let image = Image(entity: imageEntity, insertInto: managedContext)
        
        image.name = name
        image.comment = comment
        
        return image
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
    
    func addPropertyItem(location: Location, images: [Image]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let propertyItemEntity = NSEntityDescription.entity(forEntityName: "PropertyItem", in: managedContext)!
        let item = NSManagedObject(entity: propertyItemEntity, insertInto: managedContext) as! PropertyItem
        
        item.id = UUID().uuidString
        item.addToImage(NSSet(array: images))
        item.loc = location
        
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
    
    func setLocation(name: String) -> Location {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return Location()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let imageEntity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        
        let location = Location(entity: imageEntity, insertInto: managedContext)
        
        location.name = name
        
        return location
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
