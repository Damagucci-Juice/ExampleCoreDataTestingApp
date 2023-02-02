//
//  DomainEntity.swift
//  ExampleCoreDataTesingApp
//
//  Created by YEONGJIN JANG on 2023/02/01.
//

import Foundation
import CoreData

protocol DomainEntity {
    associatedtype ModelEntity
    
    func toDomain() -> ModelEntity
}

extension NumberEntity: DomainEntity {
    convenience init(number: Number, insertInto: NSManagedObjectContext) {
        self.init(context: insertInto)
        self.value = number.value
    }
    
    func toDomain() -> Number {
        return .init(value: self.value)
    }
}
