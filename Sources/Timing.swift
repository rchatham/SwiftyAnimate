//
//  Timing.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/4/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

/// Enum representing cross-api timing functions.
public enum Timing {
    
    /// Ease in timing function.
    case easeIn
    
    /// Ease out timing function.
    case easeOut
    
    /// Linear timing function.
    case linear
    
    /// Ease in-out timing function.
    case easeInOut
    
//    var viewAnimationCurve: UIViewAnimationCurve {
//        switch self {
//        case .easeIn: return .easeIn
//        case .easeOut: return .easeOut
//        case .easeInOut: return .easeInOut
//        case .linear: return .linear
//        }
//    }
    
    var coreAnimationCurve: CAMediaTimingFunction {
        switch self {
        case .easeIn: return .init(name: kCAMediaTimingFunctionEaseIn)
        case .easeOut: return .init(name: kCAMediaTimingFunctionEaseOut)
        case .easeInOut: return .init(name: kCAMediaTimingFunctionEaseInEaseOut)
        case .linear: return .init(name: kCAMediaTimingFunctionLinear)
        }
    }
    
//    var viewAnimationOptions: UIViewAnimationOptions {
//        switch self {
//        case .easeIn: return .curveEaseIn
//        case .easeOut: return .curveEaseOut
//        case .easeInOut: return .curveEaseInOut
//        case .linear: return .curveLinear
//        }
//    }
}
