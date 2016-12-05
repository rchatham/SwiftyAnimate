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
    
    func test_Animate_Performed() {
        
        var performedAnimation = false
        
        let animation = Animate(duration: 0.5) {
            performedAnimation = true
        }
        
        XCTAssertFalse(performedAnimation)
        
        animation.perform()
        
        XCTAssertTrue(performedAnimation)
    }
    
    func test_Animate_PerformedWithCompletion() {
        
        var performedAnimation = false
        var performedWithCompletion = false
        
        let animation = Animate(duration: 0.5) {
            performedAnimation = true
        }
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedWithCompletion)
        
        let expect = expectation(description: "Performed animation with completion")
        
        animation.perform {
            performedWithCompletion = true
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        
        waitForExpectations(timeout: 1.0) { error in
            if error != nil { print(error!.localizedDescription) }
            XCTAssertTrue(performedWithCompletion)
        }
    }
    
    func test_EmptyAnimate_Performed() {
        
        let animation = Animate()
        
        let expect = expectation(description: "Performed empty animation with completion")
        
        animation.perform {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { error in
            if error != nil { print(error!.localizedDescription) }
        }
        
    }
    
    func test_EmptyAnimate_PerformedWithCompletion() {
        
        var performedWithCompletion = false
        
        let animation = Animate()
        
        XCTAssertFalse(performedWithCompletion)
        
        animation.perform {
            performedWithCompletion = true
        }
        
        XCTAssertTrue(performedWithCompletion)
    }
    
    func test_EmptyAnimate_PerformedDoBlock() {
        
        var performedDoBlock = false
        
        let animation = Animate().do {
            performedDoBlock = true
        }
        
        XCTAssertFalse(performedDoBlock)
        
        animation.perform()
        
        XCTAssertTrue(performedDoBlock)
    }
    
    func test_EmptyAnimate_PerformedWaitBlock() {
        
        var performedWaitBlock = false
        
        let animation = Animate().wait { resume in
            
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
                
                XCTAssertFalse(performedWaitBlock)
                performedWaitBlock = true
                
                resume()
            }
        }
        
        XCTAssertFalse(performedWaitBlock)
        
        let expect = expectation(description: "Performed empty animation with completion")
        
        animation.perform {
            XCTAssertTrue(performedWaitBlock)
            expect.fulfill()
        }
        
        XCTAssertFalse(performedWaitBlock)
        
        waitForExpectations(timeout: 6.0) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_EmptyAnimate_Finished() {
        
        var finishedAnimation = false
        
        let animation = Animate()
        
        XCTAssertFalse(finishedAnimation)
        
        animation.finish(duration: 0.5) {
            finishedAnimation = true
        }
        
        XCTAssertTrue(finishedAnimation)
    }
    
    func test_EmptyAnimate_PerformedThenAnimation() {
        
        var performedThenAnimation = false
        
        let animation = Animate().then(duration: 0.5) {
            performedThenAnimation = true
        }
        
        XCTAssertFalse(performedThenAnimation)
        
        animation.perform()
        
        XCTAssertTrue(performedThenAnimation)
    }
    
    func test_EmptyAnimate_PerformedThenAnimationWithCompletion() {
        
        var performedThenAnimation = false
        var performedWithCompletion = false
        
        let animation = Animate().then(duration: 0.5) {
            performedThenAnimation = true
        }
        
        XCTAssertFalse(performedThenAnimation)
        XCTAssertFalse(performedWithCompletion)
        
        
        let expect = expectation(description: "Performed then animation with completion")
        
        animation.perform {
            performedWithCompletion = true
            expect.fulfill()
        }
        
        XCTAssertTrue(performedThenAnimation)
        
        waitForExpectations(timeout: 1.0) { error in
            if error != nil { print(error!.localizedDescription) }
            XCTAssertTrue(performedWithCompletion)
        }
    }
    
}
