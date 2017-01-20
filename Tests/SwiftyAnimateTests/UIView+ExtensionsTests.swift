//
//  UIView+ExtensionsTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/19/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class UIView_ExtensionsTests: XCTestCase {
    
    var animation: Animate!
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        animation = Animate()
        view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_UIView_Rotate() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        animation.then(animation: <#T##Animate#>)
    }
    
    
}
