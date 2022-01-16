//
//  otoklixSubmitionTests.swift
//  otoklixSubmitionTests
//
//  Created by Developer Xabdaz on 15/01/22.
//

import XCTest
import Swinject
@testable import otoklixSubmition

class otoklixSubmitionTests: XCTestCase {
    private let message = "TestCase OtoKlix Coordinator Error on "
    private var appCoordinator: AppCoordinator?

    let container = Container()
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

    func testRegisterCoordinator() {
        container.registerCoordinator()
        appCoordinator = container.resolve(AppCoordinator.self)
        XCTAssertNotNil(appCoordinator, "\(message) \(#function)")
    }

    func testNotRegisterCoordinator() {
        appCoordinator = container.resolve(AppCoordinator.self)
        XCTAssertNil(appCoordinator, "\(message) \(#function)")
    }

    func testMockupClient() {
        let mock = MockupClient()
        mock.request(
            resource: "posts",
            method: .get,
            json: nil) { result in
                switch result {
                case let .success(model):
                    guard let data = model.data else {
                        XCTAssertNil(model.data)
                        return
                    }
                    let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
                    let value = resource?[1].id
                    let dataStr = value.orEmpty
                    
                    XCTAssertEqual(dataStr, "385")
                case .failure:
                    break
                }
            }
    }
}
