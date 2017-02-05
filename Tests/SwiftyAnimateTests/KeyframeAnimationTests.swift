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
    
    
    func test_KeyframeAnimation_Performed() {
        
        var performedAnimation = false
        
        let animation = Animate(keyframes: [
                Keyframe(duration: 1.0, animationBlock: { performedAnimation = true })
            ])
        
        XCTAssertFalse(performedAnimation)
        
        animation.perform()
        
        XCTAssertTrue(performedAnimation)
    }
    
    func test_KeyframeAnimation_PerformedThenKeyframeAnimation() {
        
        var performedAnimation = false
        var performedThenAnimation = false
        
        let animation = Animate().then(keyframes: [
                Keyframe(duration: 1.0, animationBlock: { performedAnimation = true })
            ])
            .then(keyframes: [
                Keyframe(duration: 1.0, animationBlock: { performedThenAnimation = true })
            ])
        
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
    
    func test_KeyframeAnimation_PerformedAndKeyframeAnimation() {
        
        var performedAnimation = false
        var performedAndAnimation = false
        
        let animation = Animate().then(keyframes: [
                Keyframe(duration: 1.0, animationBlock: { performedAnimation = true })
            ])
            .and(keyframes: [
                Keyframe(duration: 1.0, animationBlock: { performedAndAnimation = true })
            ])
        
        XCTAssertFalse(performedAnimation)
        XCTAssertFalse(performedAndAnimation)
        
        let expect = expectation(description: "Performed then animation with completion")
        
        animation.perform {
            XCTAssertTrue(performedAndAnimation)
            expect.fulfill()
        }
        
        XCTAssertTrue(performedAnimation)
        XCTAssertTrue(performedAndAnimation)
        
        waitForExpectations(timeout: 1.1) { error in
            if error != nil { print(error!.localizedDescription) }
        }
    }
    
    func test_SingleKeyframe_Animation() {
        
        var performedAnimation = false
        
        let animation = Animate(animation: Keyframe(duration: 1.0, animationBlock: { performedAnimation = true }))
        
        XCTAssertFalse(performedAnimation)
        
        animation.perform()
        
        XCTAssertTrue(performedAnimation)
    }
    
    func test_timeInterval() {
        
        let keyframeAnimation = KeyframeAnimation(keyframes: [
                Keyframe(duration: 1.0, animationBlock: { }),
                Keyframe(duration: 1.5, animationBlock: { }),
                Keyframe(duration: 0.75, delay: 1.0, animationBlock: { })
            ])
     
        XCTAssert(keyframeAnimation.timeInterval == 0.75 + 1.0)
        
    }
    
    func test_EmptyAnimate_Finished_Keyframe() {
        
        var finishedAnimation = false
        
        let animation = Animate()
        
        XCTAssertFalse(finishedAnimation)
        
        animation.finish(keyframes: [Keyframe(duration: 1.0, animationBlock: { finishedAnimation = true })])
        
        XCTAssertTrue(finishedAnimation)
    }
    
    func keyframeAnimation(keyframes: [(TimeInterval,AnimationBlock)]) -> KeyframeAnimation {
        return KeyframeAnimation(
            keyframes: keyframes.map { Keyframe(duration: $0.0, animationBlock: $0.1) },
            options: []
        )
    }
    
}
