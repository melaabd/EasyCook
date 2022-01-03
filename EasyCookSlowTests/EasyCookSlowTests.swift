//
//  EasyCookSlowTests.swift
//  EasyCookSlowTests
//
//  Created by melaabd on 1/3/22.
//

import XCTest
@testable import EasyCook

class EasyCookSlowTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    let networkMonitor = NetworkMonitor.shared
    
    override func setUp() {
        super.setUp()
        
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
        try XCTSkipUnless(
            networkMonitor.isReachable,
            "Network connectivity needed for this test.")
        
        // given
        let url = URL(string: Router.baseURL + Router.getCollections.path)
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { _, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
    // Asynchronous test: faster fail
    func testApiCallCompletes() throws {
        try XCTSkipUnless(
            networkMonitor.isReachable,
            "Network connectivity needed for this test."
        )
        
        // given
        let url = URL(string: Router.baseURL + Router.getCollections.path)
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
