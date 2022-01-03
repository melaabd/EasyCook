//
//  BasicViewModelTests.swift
//  EasyCookTests
//
//  Created by melaabd on 1/3/22.
//

import XCTest
@testable import EasyCook

class HomeVMTests: XCTestCase {
    
    var homeVM: HomeVM!
    
    override func setUp() {
        super.setUp()
        
        homeVM = HomeVM()
    }
    
    override func tearDown() {
        homeVM = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(homeVM, "The view model should not be nil.")
    }
    
    func testJSONDecoding() {
        
        // Convert Collections.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Collections", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        let collections = try! JSONDecoder().decode(Collections.self, from: data)
        XCTAssertEqual(collections.first?.title, "BBQ Classics")
    }

    func testHomeVM() {
        // Convert Collections.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Collections", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        let collections = try! JSONDecoder().decode(Collections.self, from: data)
        
        homeVM.menuBarItems = []
        homeVM.homeBannerTVCellVM = collections.map {
            homeVM.menuBarItems?.append(MenuItem(id: $0.id, titleName: $0.title))
            return HomeBannerTVCellVM(id: $0.id, banners: $0.previewImageUrls)
        }
        
        XCTAssertEqual(homeVM.menuBarItems?.first?.titleName, "BBQ Classics")
        XCTAssertEqual(homeVM.homeBannerTVCellVM?.first?.imgsURLs, ["https://img-global.cpcdn.com/recipes/65555efe64df98ce/m/photo.jpg"])
    }
}
