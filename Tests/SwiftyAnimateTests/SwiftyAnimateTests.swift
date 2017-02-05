//
//  SwiftyAnimateTests.swift
//  SwiftyAnimateTests
//
//  Created by Reid Chatham on 12/4/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class SwiftyAnimateTests: XCTestCase {
    
    static var allTests : [(String, (SwiftyAnimateTests) -> () throws -> Void)] {
        return [
            ("test_Animate_Performed", test_Animate_Performed),
            ("test_Animate_PerformedWithCompletion", test_Animate_PerformedWithCompletion),
            ("test_EmptyAnimate_Performed", test_EmptyAnimate_Performed),
            ("test_EmptyAnimate_PerformedWithCompletion", test_EmptyAnimate_PerformedWithCompletion),
            ("test_EmptyAnimate_PerformedDoBlock", test_EmptyAnimate_PerformedDoBlock),
//            ("test_EmptyAnimate_PerformedWaitBlock", test_EmptyAnimate_PerformedWaitBlock),
//            ("test_EmptyAnimate_Finished", test_EmptyAnimate_Finished),
//            ("test_EmptyAnimate_PerformedThenAnimation", test_EmptyAnimate_PerformedThenAnimation),
//            ("test_EmptyAnimate_PerformedThenAnimationWithCompletion", test_EmptyAnimate_PerformedThenAnimationWithCompletion),
        ]
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
        
        let animation = Animate(duration: 0.5) {
            performedAnimation = true
        }
        
        XCTAssertFalse(performedAnimation)
        
        let expect = expectation(description: "Performed animation with completion")
        
        animation.perform {
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        
        waitForExpectations(timeout: 1.0) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_EmptyAnimate_AndPerformed() {
        
        var performedAnimation = false
        var performedAndAnimation = false
        
        let expect = expectation(description: "Performed animation with completion")
        
        Animate(duration: 0.5) {
            performedAnimation = true
        }
        .and(duration: 0.5) {
            performedAndAnimation = true
        }
        .perform {
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertTrue(performedAndAnimation)
        
        waitForExpectations(timeout: 0.6) { error in
            if error != nil { print(error!.localizedDescription) }
        }
        
    }
    
    func test_EmptyAnimate_AndAnimation_Performed() {
        
        var performedAnimation = false
        var performedAndAnimation = false
        
        let expect = expectation(description: "Performed animation with completion")
        
        let animation = Animate(duration: 0.5) {
            performedAndAnimation = true
        }
        
        Animate(duration: 0.5) {
                performedAnimation = true
            }
            .and(animation: animation)
            .perform {
                expect.fulfill()
            }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertTrue(performedAndAnimation)
        
        waitForExpectations(timeout: 0.6) { error in
            if error != nil { print(error!.localizedDescription) }
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
            
            self.resumeBlock = {
                XCTAssertFalse(performedWaitBlock)
                performedWaitBlock = true
                
                resume()
                self.resumeBlock = nil
            }
            
            if #available(iOS 10.0, *) {
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] timer in
                    self?.resumeBlock?()
                }
            } else {
                Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(SwiftyAnimateTests.resume(_:)), userInfo: nil, repeats: false)
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
    
    func test_EmptyAnimate_PerformedWaitBlock_WithTimeout() {
        
        var performedWaitBlock = false
        var performedDoBlock = false
        
        let animation = Animate().wait(timeout: 1.0) { resume in
            
            self.resumeBlock = {
                XCTAssertFalse(performedWaitBlock)
                performedWaitBlock = true
                
                resume()
                self.resumeBlock = nil
            }
            
            if #available(iOS 10.0, *) {
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] timer in
                    self?.resumeBlock?()
                }
            } else {
                Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(SwiftyAnimateTests.resume(_:)), userInfo: nil, repeats: false)
            }
            
        }.do {
            performedDoBlock = true
        }
        
        XCTAssertFalse(performedWaitBlock)
        XCTAssertFalse(performedDoBlock)
        
        let expect = expectation(description: "Performed empty animation with completion")
        
        animation.perform {
            XCTAssertFalse(performedWaitBlock)
            XCTAssertTrue(performedDoBlock)
            expect.fulfill()
        }
        
        XCTAssertFalse(performedWaitBlock)
        XCTAssertFalse(performedDoBlock)
        
        waitForExpectations(timeout: 2.0) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_EmptyAnimate_Wait_Timeout() {
        
        var performedDoBlock = false
        
        let animation = Animate().wait(timeout: 1.0).do {
                performedDoBlock = true
        }
        
        XCTAssertFalse(performedDoBlock)
        
        let expect = expectation(description: "Performed empty animation with completion")
        
        animation.perform {
            XCTAssertTrue(performedDoBlock)
            expect.fulfill()
        }
        
        XCTAssertFalse(performedDoBlock)
        
        waitForExpectations(timeout: 2.0) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_EmptyAnimate_DidDecay() {
        
        var performedDoBlock = false
        
        let animation = Animate().do {
            performedDoBlock = true
        }
        
        XCTAssertFalse(performedDoBlock)
        
        animation.decay()
        
        XCTAssertFalse(performedDoBlock)
        
        animation.perform()
        
        XCTAssertFalse(performedDoBlock)
        
    }
    
    // Feels like this should include a check that the then block was not called before 2.0 seconds but currently a Timer finds that it gets called already? This is probably due to semantics of the UIView animation API.
    func test_Animation_DidDelay() {
        
        var performedAnimation = false
        var performedThenAnimation = false
        
        let animation = Animate(duration: 0.5, delay: 2.0, options: []) {
            performedAnimation = true
        }.then(duration: 0.5) {
            performedThenAnimation = true
        }
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        let expect = expectation(description: "Performed then animation with delay")
        
        animation.perform {
            XCTAssertTrue(performedAnimation)
            XCTAssertTrue(performedThenAnimation)
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        waitForExpectations(timeout: 3.5) { error in
            if error != nil { print(error!.localizedDescription) }
        }
        
    }
    
    func test_Animate_Copy() {
        
        var performedAnimation = false
        var performedAnimationTwice = false
        
        let animation = Animate(duration: 0.5) {
            if performedAnimation {
                performedAnimationTwice = true
            } else {
                performedAnimation = true
            }
        }
        
        let copy = animation.copy
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedAnimationTwice)
        
        animation.perform()
        
        XCTAssertTrue(performedAnimation)
        XCTAssertFalse(performedAnimationTwice)
        
        copy.perform()
        
        XCTAssertTrue(performedAnimation)
        XCTAssertTrue(performedAnimationTwice)
    }
    
    func test_Animate_DecayPerformance() {
        
        let animation = Animate()
        
        for _ in 0..<1000 {
            _ = animation.then(duration: 0.3) {
                print("do something that takes time like writing to the terminal")
            }
        }
        
        measure {
            animation.decay()
        }
        
    }
    
    private var resumeBlock: ResumeBlock?
    
    internal func resume(_ sender: Timer) {
        resumeBlock?()
    }
}
