//
//  PropertyItem+CoreDataProperties.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/29/17.
//  Copyright © 2017 pic360. All rights reserved.
//
//

import Foundation
import CoreData


extension PropertyItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PropertyItem> {
        return NSFetchRequest<PropertyItem>(entityName: "PropertyItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: NSSet?
    @NSManaged public var loc: Location?

}

// MARK: Generated accessors for image
extension PropertyItem {

    @objc(addImageObject:)
    @NSManaged public func addToImage(_ value: Image)

    @objc(removeImageObject:)
    @NSManaged public func removeFromImage(_ value: Image)

    @objc(addImage:)
    @NSManaged public func addToImage(_ values: NSSet)

    @objc(removeImage:)
    @NSManaged public func removeFromImage(_ values: NSSet)

}
