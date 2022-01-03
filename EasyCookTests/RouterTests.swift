//
//  RouterTests.swift
//  EasyCookTests
//
//  Created by melaabd on 1/3/22.
//

import XCTest
import Alamofire
@testable import EasyCook

class RouterTests: XCTestCase {

    var router:Router!
    
    override func setUp() {
        super.setUp()
        
        router = Router.getCollections
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }
    
    func testRouterRequest() throws {
        let request:URLRequest = try router.asURLRequest()
        XCTAssertNoThrow(request)
        XCTAssertEqual(URL(string: "https://cookpad.github.io/global-mobile-hiring/api/collections/"), request.url)
        XCTAssertEqual(HTTPMethod.get, request.method)
    }
}
