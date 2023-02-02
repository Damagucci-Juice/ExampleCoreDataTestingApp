//
//  ExampleCoreDataTesingAppTests.swift
//  ExampleCoreDataTesingAppTests
//
//  Created by YEONGJIN JANG on 2023/02/01.
//

import XCTest
@testable import ExampleCoreDataTesingApp

final class ExampleCoreDataTesingAppTests: XCTestCase {

    var numberStorage: NumberStorage!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let testCoreDataStorage = TestCoreDataStorage()
        numberStorage = CoreDataNumberStorage(coreDataStorage: testCoreDataStorage)
    }

    override func tearDownWithError() throws {
        numberStorage = nil
        try super.tearDownWithError()
    }
    
    func testSaveNumbers() async {
        // Given
        let mockNumber = makeMockNumbers([1])
        
        // When
        let isSuccess = await numberStorage.save(mockNumber.first!)
        
        // Then
        XCTAssertTrue(isSuccess)
    }
    
    func testGetNumbers() async throws {
        // Given
        let mockNumbers = makeMockNumbers([1,2,3,4,5])
        do {
            // saving
            for number in mockNumbers {
                _ = await numberStorage.save(number)
            }
            
            // When
            let fetchedNumbers = try await numberStorage.get().sorted { $0.value < $1.value }
            
            // Then
            XCTAssertEqual(fetchedNumbers.count, mockNumbers.count)
            XCTAssertEqual(fetchedNumbers, mockNumbers)
        } catch {
            assertionFailure()
        }
        
    }
}

extension ExampleCoreDataTesingAppTests {
    private func makeMockNumbers(_ arr: [Int]) -> [Number] {
        return arr.map { Number(value: Int64($0))}
    }
}
