//
//  TimingTests.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/20/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import XCTest
@testable import SwiftyAnimate

class TimingTests: XCTestCase {
    
    func test_Timing_CAMediaTimingFunction() {
        XCTAssert(Timing.easeIn.coreAnimationCurve == CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        XCTAssert(Timing.easeOut.coreAnimationCurve == CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
        XCTAssert(Timing.easeInOut.coreAnimationCurve == CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        XCTAssert(Timing.linear.coreAnimationCurve == CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
    }
    
}
