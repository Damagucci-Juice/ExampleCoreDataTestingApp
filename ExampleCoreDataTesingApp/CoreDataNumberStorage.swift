//
//  CoreDataNumberStorage.swift
//  ExampleCoreDataTesingApp
//
//  Created by YEONGJIN JANG on 2023/02/01.
//

import CoreData

class CoreDataNumberStorage {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
}

//MARK: - Public
extension CoreDataNumberStorage: NumberStorage {
    func get() async throws -> [Number] {
        try await withCheckedThrowingContinuation { continuation in
            get { result in
                switch result {
                case .success(let numbers):
                    continuation.resume(returning: numbers)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func save(_ object: Number) async -> Bool {
        await withCheckedContinuation { continuation in
            save(number: object) { isSuccess in
                continuation.resume(returning: isSuccess)
            }
        }
    }
}

//MARK: - Private
extension CoreDataNumberStorage {
    private func get(_ completion: @escaping (Result<[Number], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = NumberEntity.fetchRequest()
                let result = try context.fetch(request).map { $0.toDomain() }
                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError))
            }
        }
    }
    
    private func save(number: Number, _ completion: @escaping (Bool) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                _ = NumberEntity(number: number, insertInto: context)
                try context.save()
                completion(true)
            } catch {
                completion(false)
            }
        }
    }
}
