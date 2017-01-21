//
//  KeyframeAnimationTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/20/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class KeyframeAnimationTests: XCTestCase {
    
    var animation: Animate!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        animation = Animate()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        animation = nil
    }
    
    func test_KeyframeAnimation_Performed() {
        
        var performedAnimation = false
        
        let keyframe = keyframeAnimation(
            keyframes: [
                (1.0, ({ performedAnimation = true }))
            ]
        )
        
        _ = animation.then(keyframe: keyframe)
        
        XCTAssertFalse(performedAnimation)
        
        animation.perform()
        
        XCTAssertTrue(performedAnimation)
    }
    
    func test_KeyframeAnimation_PerformedThenKeyframeAnimation() {
        
        var performedAnimation = false
        var performedThenAnimation = false
        
        let keyframe1 = keyframeAnimation(
            keyframes: [
                (1.0, ({ performedAnimation = true }))
            ]
        )
        
        let keyframe2 = keyframeAnimation(
            keyframes: [
                (1.0, ({ performedThenAnimation = true }))
            ]
        )
        
        _ = animation.then(keyframe: keyframe1).then(keyframe: keyframe2)
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        let expect = expectation(description: "Performed then animation with completion")
        
        animation.perform {
            XCTAssertTrue(performedThenAnimation)
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertFalse(performedThenAnimation)
        
        waitForExpectations(timeout: 2.1) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func keyframeAnimation(keyframes: [(TimeInterval,AnimationBlock)]) -> KeyframeAnimation {
        return KeyframeAnimation(
            keyframes: keyframes.map { Keyframe(duration: $0.0, animationBlock: $0.1) },
            options: []
        )
    }
    
}
