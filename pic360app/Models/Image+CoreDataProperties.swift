//
//  Image+CoreDataProperties.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/29/17.
//  Copyright © 2017 pic360. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var name: String?
    @NSManaged public var comment: String?
    @NSManaged public var pi: PropertyItem?

}
