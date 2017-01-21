//
//  AnimationTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/20/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class AnimationTests: XCTestCase {
    
    let mocks = [
        MockAnimation(duration: 1.0, delay: 1.0, animationBlock: {}),
        MockAnimation(duration: 0.5, delay: 0.2, animationBlock: {}),
        MockAnimation(duration: 0.8, delay: 1.4, animationBlock: {})
    ]
    
    func test_Animation_TimeInterval() {
        XCTAssert(mocks[0].timeInterval == 2.0)
    }
    
    func test_Animation_Collection_TimeInterval() {
        XCTAssert(mocks.timeInterval == 2.2)
    }
    
    func test_Animation_Collection_Delay() {
        XCTAssert(mocks.delay == 0.2)
    }
}

struct MockAnimation: Animation {
    let duration: TimeInterval
    var delay: TimeInterval
    var animationBlock: AnimationBlock
    func performAnimations(completion: ((Bool) -> Void)?) {
        completion?(true)
    }
}
