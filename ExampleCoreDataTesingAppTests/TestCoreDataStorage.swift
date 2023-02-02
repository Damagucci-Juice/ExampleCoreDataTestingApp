//
//  TestCoreDataStorage.swift
//  ExampleCoreDataTesingAppTests
//
//  Created by YEONGJIN JANG on 2023/02/01.
//

import CoreData
@testable import ExampleCoreDataTesingApp

class TestCoreDataStorage: CoreDataStorage {
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: CoreDataStorage.modelName,
                                              managedObjectModel: CoreDataStorage.model)
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }
}
