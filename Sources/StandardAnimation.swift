//
//  Animation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

/// Represents a standard animation.
public struct StandardAnimation: Animation {
    /// The duration over which to perform the animation.
    public let duration: TimeInterval
    /// The delay after which to perform the animation.
    public let delay: TimeInterval
    /// The options to apply to the animation.
    public let options: UIViewAnimationOptions
    /// The aniamtion block containing the animations to perform.
    public let animationBlock: AnimationBlock
    
    /// Performs the animations for the aniamtion object with the given completion handler.
    /// - parameter completion: The completion handler when the animation finishes.
    public func performAnimations(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: animationBlock, completion: completion)
    }
}
