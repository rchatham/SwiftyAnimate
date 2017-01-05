//
//  Timing.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/4/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

public enum Timing {
    case easeIn
    case easeOut
    case linear
    case easeInOut
    
    var viewAnimationCurve: UIViewAnimationCurve {
        switch self {
        case .easeIn: return .easeIn
        case .easeOut: return .easeOut
        case .easeInOut: return .easeInOut
        case .linear: return .linear
        }
    }
    
    var coreAnimationCurve: CAMediaTimingFunction {
        switch self {
        case .easeIn: return .init(name: kCAMediaTimingFunctionEaseIn)
        case .easeOut: return .init(name: kCAMediaTimingFunctionEaseOut)
        case .easeInOut: return .init(name: kCAMediaTimingFunctionEaseInEaseOut)
        case .linear: return .init(name: kCAMediaTimingFunctionLinear)
        }
    }
}
