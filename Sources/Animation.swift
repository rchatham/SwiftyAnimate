//
//  Animation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

/// Protocol representing an instance of an animation.
public protocol Animation {
    /// The duration over which to perform the animation.
    var duration: TimeInterval { get }
    /// The delay after which to perform the animation.
    var delay: TimeInterval { get }
    /// Block containing the animations to perform.
    var animationBlock: AnimationBlock { get }
    
    /// Performs the animations for the aniamtion object with the given completion handler.
    /// - parameter completion: The completion handler when the animation finishes.
    func performAnimations(completion: ((Bool)->Void)?)
}

extension Animation {
    
    /// The time interval after which the animation will complete.
    var timeInterval: TimeInterval {
        return delay + duration
    }
}
