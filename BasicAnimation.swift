//
//  BasicAnimation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

public enum BasicAnimation {
    case cornerRadius(view: UIView, duration: TimeInterval, delay: TimeInterval, radius: CGFloat, timing: Timing)
}

extension BasicAnimation: Animation {
    
    public var duration: TimeInterval {
        switch self {
        case .cornerRadius(view: _, duration: let duration, delay: _, radius: _, timing: _):
            return duration
        }
    }
    
    public var delay: TimeInterval {
        switch self {
        case .cornerRadius(view: _, duration: _, delay: let delay, radius: _, timing: _):
            return delay
        }
    }
    
    public var animationBlock: AnimationBlock {
        switch self {
        case .cornerRadius(view: let view, duration: let duration, delay: _, radius: let radius, timing: let timing):
            return {
                let animation = CABasicAnimation(keyPath: "cornerRadius")
                animation.timingFunction = timing.coreAnimationCurve
                animation.fromValue = view.layer.cornerRadius
                animation.toValue = radius
                animation.duration = duration
                view.layer.add(animation, forKey: "corner")
                view.layer.cornerRadius = radius
            }
        }
    }
}

