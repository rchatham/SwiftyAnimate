//
//  FinishAnimationTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 2/4/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class FinishAnimationTests: XCTestCase {
    
    func test_EmptyAnimate_Finished() {
        
        var finishedAnimation = false
        
        let animation = Animate()
        
        XCTAssertFalse(finishedAnimation)
        
        animation.finish(duration: 0.5) {
            finishedAnimation = true
        }
        
        XCTAssertTrue(finishedAnimation)
    }
    
    func test_EmptyAnimate_Finished_Animation() {
        
        var finishedAnimation = false
        
        let animation = Animate(duration: 0.5) {
            finishedAnimation = true
        }
        
        XCTAssertFalse(finishedAnimation)
        
        Animate().finish(animation: animation)
        
        XCTAssertTrue(finishedAnimation)
    }
    
    func test_EmptyAnimate_Finished_Keyframe() {
        
        var finishedAnimation = false
        
        let animation = Animate()
        
        XCTAssertFalse(finishedAnimation)
        
        let keyframe = KeyframeAnimation(keyframes: [
            Keyframe(duration: 1.0) {
                finishedAnimation = true
            }], options: [])
        
        animation.finish(animation: keyframe)
        
        XCTAssertTrue(finishedAnimation)
    }
    
}
