//
//  SpringAnimationTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/20/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class SpringAnimationTests: XCTestCase {
    
    func test_SpringAnimation_Performed() {
        
        var performedAnimation = false
        
        let animation = Animate(duration: 0.5, springDamping: 1.0, initialVelocity: 0.5) {
            performedAnimation = true
        }
        
        XCTAssertFalse(performedAnimation)
        
        animation.perform()
        
        XCTAssertTrue(performedAnimation)
    }
    
    
    func test_SpringAnimation_PerformedWithCompletion() {
        
        var performedAnimation = false
        var performedWithCompletion = false
        
        let animation = Animate(duration: 0.5, springDamping: 1.0, initialVelocity: 0.5) {
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
        
        _ = Wait(timeout: 0.6) {
            XCTAssertTrue(performedWithCompletion)
        }
        
        waitForExpectations(timeout: 0.6) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_SpringAnimation_PerformedThenAnimation() {
        
        var performedAnimation = false
        var performedThenAnimation = false
        
        let animation = Animate(duration: 0.5, springDamping: 1.0, initialVelocity: 0.5) {
            performedAnimation = true
        }.then(duration: 0.5, springDamping: 1.0, initialVelocity: 0.5) {
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
    
    func test_SpringAnimation_PerformedAndAnimation() {
        
        var performedAnimation = false
        var performedAndAnimation = false
        
        let animation = Animate(duration: 0.5, springDamping: 1.0, initialVelocity: 0.5) {
                performedAnimation = true
            }
            .and(duration: 0.5, springDamping: 1.0, initialVelocity: 0.5) {
                performedAndAnimation = true
            }
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedAndAnimation)
        
        let expect = expectation(description: "Performed then animation with completion")
        
        animation.perform {
            XCTAssertTrue(performedAndAnimation)
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertTrue(performedAndAnimation)
        
        waitForExpectations(timeout: 0.6) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_EmptyAnimate_Finished_Spring() {
        
        var finishedAnimation = false
        
        let animation = Animate()
        
        XCTAssertFalse(finishedAnimation)
        
        animation.finish(duration: 0.5, springDamping: 1.0, initialVelocity: 0.5) {
            finishedAnimation = true
        }
        
        XCTAssertTrue(finishedAnimation)
    }
}
