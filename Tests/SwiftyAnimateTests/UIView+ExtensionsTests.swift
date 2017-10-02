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
    
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        view = nil
        super.tearDown()
    }
    
    func test_UIView_Rotated() {
        
        XCTAssert(view.transform == CGAffineTransform(rotationAngle: 0))
        
        view.rotate(duration: 0.3, angle: -60).perform()
        
        XCTAssert(view.transform == CGAffineTransform(rotationAngle: CGFloat(-60.0 * .pi / 180.0)))
    }
    
    func test_UIView_Scaled() {
        
        XCTAssert(view.transform == CGAffineTransform(scaleX: 1.0, y: 1.0))
        
        view.scale(duration: 0.3, x: 1.3, y: 1.3).perform()
        
        XCTAssert(view.transform == CGAffineTransform(scaleX: 1.3, y: 1.3))
    }
    
    func test_UIView_Translated() {
        
        XCTAssert(view.transform == CGAffineTransform(translationX: 0, y: 0))
        
        view.move(duration: 0.3, x: 10, y: 10).perform()
        
        XCTAssert(view.transform == CGAffineTransform(translationX: 10, y: 10))
    }
    
    func test_UIView_Transform() {
        
        XCTAssert(view.transform == CGAffineTransform(translationX: 0, y: 0))
        
        view.transform(duration: 0.3, transforms: [
                .rotate(angle: 90),
                .scale(x: 1.5, y: 1.5),
                .move(x: -10, y: -10),
            ]).perform()
        
        XCTAssert(view.transform == CGAffineTransform(rotationAngle: 90 * CGFloat(Double.pi / 180))
            .scaledBy(x: 1.5, y: 1.5)
            .translatedBy(x: -10, y: -10))
    }
    
    func test_UIView_Corner() {
        
        XCTAssert(view.layer.cornerRadius == 0)
        
        view.corner(duration: 0.3, radius: 5).perform()
        
        XCTAssert(view.layer.cornerRadius == 5)
    }
    
    func test_Animate_Color() {
        
        view.backgroundColor = .white
        
        XCTAssert(view.backgroundColor == .white)
        
        view.color(duration: 0.3, color: .blue).perform()
        
        XCTAssert(view.backgroundColor == .blue)
    }
    
}
