//
//  Location+CoreDataProperties.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/29/17.
//  Copyright © 2017 pic360. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var pi: PropertyItem?

}
