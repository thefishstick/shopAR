//
//  shopARTests.swift
//  shopARTests
//
//  Created by Johan Todi on 2019-09-07.
//  Copyright © 2019 GFE. All rights reserved.
//

import XCTest
@testable import shopAR

class shopARTests: XCTestCase {
    
    var shop_ar: shopAR!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        shop_ar = shopAR()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAdd() {
        XCTAssertEqual(shop_ar.add(a: 1, b: 1), 2)
    }
    
    func testSubtract() {
        XCTAssertEqual(shop_ar.sub(a: 2, b: 1), 1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
