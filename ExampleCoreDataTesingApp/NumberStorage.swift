//
//  NumberStorage.swift
//  ExampleCoreDataTesingApp
//
//  Created by YEONGJIN JANG on 2023/02/01.
//

import Foundation

protocol NumberStorage {
    func get() async throws -> [Number]
    func save(_ object: Number) async -> Bool 
}
