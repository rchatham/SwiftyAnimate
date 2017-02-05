//
//  ThenAnimationTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 2/4/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class ThenAnimationTests: XCTestCase {
    
    
    func test_Animate_PerformedThenAnimation() {
        
        var performedAnimation = false
        var performedThenAnimation = false
        
        let animation = Animate(duration: 0.5) {
            performedAnimation = true
            }.then(duration: 0.5) {
                performedThenAnimation = true
        }
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        let expect = expectation(description: "Performed then animation with completion")
        
        animation.perform {
            XCTAssertTrue(performedThenAnimation)
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        waitForExpectations(timeout: 1.1) { error in
            if error != nil { print(error!.localizedDescription) }
        }
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
    
    
    func test_Animate_ThenAnimation() {
        
        var performedAnimation = false
        var performedThenAnimation = false
        
        let thenAnimation = Animate(duration: 1.0) {
            performedThenAnimation = true
        }
        
        let animation = Animate(duration: 1.0) {
            performedAnimation = true
            }
            .then(animation: thenAnimation)
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        let expect = expectation(description: "Performed then animation")
        
        animation.perform {
            XCTAssertTrue(performedAnimation)
            XCTAssertTrue(performedThenAnimation)
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        waitForExpectations(timeout: 2.5) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_EmptyAnimate_ThenAnimation() {
        
        var performedThenAnimation = false
        
        let thenAnimation = Animate(duration: 1.0) {
            performedThenAnimation = true
        }
        
        let animation = Animate().then(animation: thenAnimation)
        
        XCTAssertFalse(performedThenAnimation)
        
        animation.perform {
            XCTAssertTrue(performedThenAnimation)
        }
        
        XCTAssertTrue(performedThenAnimation)
    }
    
}
