//
//  Keyframe.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 12/26/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit

/**
 Represents a keyframe animation.
 */
public struct KeyframeAnimation {
    /// The `Keyframe` objects representing the keyframes to be animated.
    public let keyframes: [Keyframe]
    /// The `UIViewKeyframeAnimationOptions` to apply to the animation.
    public let options: UIViewKeyframeAnimationOptions
    
    /**
     Initializes and returns a `KeyframeAnimation` instance representing a keyframe animation.
     
     - parameter keyframes: An array of `Keyframe` objects representing the keyframes to be animated.
     - parameter options: The `UIViewKeyframeAnimationOptions` to apply to the animation.
     
     - returns An initialized `KeyframeAnimation` instance.
     */
    public init(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) {
        self.keyframes = keyframes
        self.options = options
    }
}

extension KeyframeAnimation: Animation {
    
    /// The delay before the begginging of the animation.
    public var delay: TimeInterval {
        return keyframes.delay
    }
    
    /// The duration of the animation.
    public var duration: TimeInterval {
        return keyframes.timeInterval - delay
    }
    
    /// The animation block to pass to a `UIView` keyframe animation.
    public var animationBlock: AnimationBlock {
        return {
            for keyframe in self.keyframes {
                
                let relativeStartTime: Double = {
                    let relativeDelay = keyframe.delay - self.delay
                    return relativeDelay / self.duration
                }()
                
                let relativeDuration: Double = {
                    return keyframe.duration / self.duration
                }()
                
                UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: keyframe.animationBlock)
            }
        }
    }
}

/**
 Represents a keyframe as part of a keyframe animation.
 */
public struct Keyframe: Animation {
    /// The delay before the keyframe.
    public let delay: TimeInterval
    /// The duration of the keyframe animation.
    public let duration: TimeInterval
    /// The animation block for the keyframe.
    public let animationBlock: AnimationBlock
    
    /**
     Initializes a `Keyframe` struct representing a keyframe animation.
     
     - parameter duration: The length of the keyframe.
     - parameter delay: The length of the delay before the the keyframe.
     - parameter animationBlock: The animation closure to be performed.
     
     - returns: Returns an initialized Keyframe struct.
     */
    public init(duration: TimeInterval, delay: TimeInterval = 0.0, animationBlock: @escaping AnimationBlock) {
        self.duration = duration
        self.delay = delay
        self.animationBlock = animationBlock
    }
}
