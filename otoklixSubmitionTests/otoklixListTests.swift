//
//  otoklixListTests.swift
//  otoklixSubmitionTests
//
//  Created by Developer Xabdaz on 15/01/22.
//

import XCTest
@testable import otoklixSubmition

class otoklixListTests: XCTestCase {

    func getData() -> Data {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "list", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            return Data()
        }
        return data
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testJSONDecoding() {

        let data = self.getData()
        // Provie any Codable struct
        let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
        let value = resource?[1].id
        let dataStr = value.orEmpty
        
        XCTAssertEqual(dataStr, "385")
    }

    func testIdInteger() {
        let data = self.getData()

        let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
        let value = resource?[0].id
        XCTAssertEqual(value, "379")
    }

    func testIdString() {
        let data = self.getData()

        let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
        let value = resource?[1].id
        XCTAssertEqual(value, "385")
    }

    func testIdBlank() {
        let data = self.getData()

        let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
        let value = resource?[2].id
        XCTAssertEqual(value, "")
    }

    func testIdNull() {
        let data = self.getData()

        let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
        let value = resource?[3].id
        XCTAssertNil(value)
    }

    func testIdWithoutId() {
        let data = self.getData()

        let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
        let value = resource?[4].id
        XCTAssertNil(value)
    }

    
}
