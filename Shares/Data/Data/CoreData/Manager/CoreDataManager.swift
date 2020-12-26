//
//  CoreDataManager.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 16/12/2563 BE.
//

import Foundation
import CoreData

public enum CoreDataName {
    case data
}

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    lazy var dataPersistentContainer: NSPersistentContainer = {
        let modelURL = Bundle(identifier: "com.rolland.Data")?.url(forResource: "Data", withExtension: "momd")
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL!)
        
        let container = NSPersistentContainer(name: "CoreData", managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            
            if let err = error {
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        return container
    }()
    
    func getPersistentContainer(coreDataType: CoreDataName) -> NSPersistentContainer {
        switch coreDataType {
        case .data:
            return self.dataPersistentContainer
        }
    }
}
