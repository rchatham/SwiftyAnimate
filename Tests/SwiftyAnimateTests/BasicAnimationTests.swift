//
//  BasicAnimationTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/20/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class BasicAnimationTests: XCTestCase {
    
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        view = nil
    }
    
    func test_Corner_WithDelay() {
        
        
        
        view.cornerRadius(5, duration: 1.0, delay: 1.0, timing: .easeInOut).perform()
        
    }
    
}
