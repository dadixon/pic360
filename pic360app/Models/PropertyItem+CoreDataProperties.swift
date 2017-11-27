//
//  PropertyItem+CoreDataProperties.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/24/17.
//  Copyright © 2017 pic360. All rights reserved.
//
//

import Foundation
import CoreData


extension PropertyItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PropertyItem> {
        return NSFetchRequest<PropertyItem>(entityName: "PropertyItem")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var location: String
    @NSManaged public var imgName: String
    @NSManaged public var serialNumber: String?
    @NSManaged public var desc: String?
//
//    func createPropertyItem(moc: NSManagedObjectContext, name: String, location: String, imgName: String, desc: String?, serialNumber: String?) -> PropertyItem {
//        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: moc) as! PropertyItem
//        newItem.id = UUID().uuidString
//        newItem.name = name
//        newItem.location = location
//        newItem.imgName = imgName
//        newItem.serialNumber = serialNumber
//        newItem.desc = desc
//
//        return newItem
//    }
}
