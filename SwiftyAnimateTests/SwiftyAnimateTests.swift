//
//  SwiftyAnimateTests.swift
//  SwiftyAnimateTests
//
//  Created by Reid Chatham on 12/4/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import XCTest
import SwiftyAnimate

class SwiftyAnimateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEmptyAnimateObject() {
        
        let animation = Animate()
        
        var didDo = false
        
        animation.then(duration: 0.5) {
            //do nothing
        }.do {
            didDo = true
        }
        
        XCTAssert(didDo == false, "Animation not performed")
        
        animation.perform()
        
        expectation(description: "Animation performed")
        
        waitForExpectations(timeout: 1.0, handler: <#T##XCWaitCompletionHandler?##XCWaitCompletionHandler?##(Error?) -> Void#>)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
