//
//  BasicAnimation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

/// Enum of the supported basic animations with this framework.
public enum BasicAnimation {
    /**
     Case representing a corner radius animation on a view.
     
     - parameter view: The `UIView` on which to perform the corner radius animation.
     - parameter duration: The `TimeInterval` over which to perform the animation.
     - parameter delay: The `TimeInterval` after which to perform the animation.
     - parameter radius: The corner radius to animate to.
     - parameter timing: The animation timing function to use for the animation.
     */
    case cornerRadius(view: UIView, duration: TimeInterval, delay: TimeInterval, radius: CGFloat, timing: Timing)
    
}

extension BasicAnimation: Animation {
    
    /// The duration over which to perform the animation.
    public var duration: TimeInterval {
        switch self {
        case .cornerRadius(view: _, duration: let duration, delay: _, radius: _, timing: _):
            return duration
        }
    }
    
    /// The delay after which to perform the animation.
    public var delay: TimeInterval {
        switch self {
        case .cornerRadius(view: _, duration: _, delay: let delay, radius: _, timing: _):
            return delay
        }
    }
    
    /// The animation block that gets performed.
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
    
    /// Performs the animations for the aniamtion object with the given completion handler.
    /// - parameter completion: The completion handler when the animation finishes.
    public func performAnimations(completion: ((Bool) -> Void)?) {
        BasicAnimationBlock(duration: duration, delay: delay, animationBlock: animationBlock, completion: completion)
    }
    
}

