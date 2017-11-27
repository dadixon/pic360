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
    
    func addPropertyItem(name: String, location: String, imgPath: String, description: String, serialNumber: String) {
        persistencyManager.addPropertyItem(name: name, location: location, imgPath: imgPath, description: description, serialNumber: serialNumber)
    }
    
    func getLocations() -> [String] {
        return persistencyManager.getLocations()
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
}
