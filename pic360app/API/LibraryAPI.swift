//
//  LibraryAPI.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/12/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import Foundation
import UIKit

final class LibraryAPI {
    static let sharedInstance = LibraryAPI()
    private let persistencyManager = PersistencyManager()
    
    private init() {
    }
    
    func getPropertyItemById(_ id: String) -> PropertyItem {
        return persistencyManager.getPropertyItemById(id: id)
    }
    
    func getPropertyItems(_ location: String) -> [PropertyItem] {
        return persistencyManager.getPropertyItems(location: location)
    }
    
    func addPropertyItem(location: Location, images: [Image]) {
        persistencyManager.addPropertyItem(location: location, images: images)
    }
    
    func getLocations() -> [String] {
        return persistencyManager.getLocations()
    }
    
    func setLocation(name: String) -> Location {
        return persistencyManager.setLocation(name: name)
    }
    
    func addLocation(_ name: String) {
        persistencyManager.saveLocation(name: name)
    }
    
    func deleteLocation(_ name: String) {
        persistencyManager.deleteLocation(name: name)
    }
    
    func getLocationAmount(_ location: String) -> Int {
        return persistencyManager.getLocationAmount(location: location)
    }
    
    func setImage(name: String, comment: String) -> Image {
        return persistencyManager.setImage(name: name, comment: comment)
    }
}
