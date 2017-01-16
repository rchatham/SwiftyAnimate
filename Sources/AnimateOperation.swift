//
//  AnimateOperation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 12/12/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit


/// Enum of supported animation operations.
public enum AnimateOperation {
    
    /**
     Animation operation.
     
     - parameter: Takes an object that conforms to the `Animation` protocol.
     */
    case animation(Animation)
    
    /**
     Wait operation.
     
     - parameter timeout: `TimeInterval?` to to resume by if resume is not called by the `Wait` block. Pass in `nil` to disable timeout.
     - parameter block: `Wait` block to pause animations.
     */
    case wait(timeout: TimeInterval?, block: WaitBlock)
    
    /**
     Do operation.
     
     - parameter `DoBlock` block to perform between animations.
     */
    case `do`(block: DoBlock)
}

extension AnimateOperation {
    
//    var timeInterval: TimeInterval? {
//        switch self {
//        case .animation(let animation):
//            return animation.timeInterval
//        case .wait(timeout: let timeout, block: _):
//            return timeout
//        case .do(block: _):
//            return nil
//        }
//    }
//    
//    var delay: TimeInterval {
//        switch self {
//        case .animation(let animation):
//            return animation.delay
//        case .wait:
//            return 0.0
//        case .do:
//            return 0.0
//        }
//    }
}
