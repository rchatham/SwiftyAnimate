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
    public let keyframes: [Keyframe]
    public let options: UIViewKeyframeAnimationOptions
}

extension KeyframeAnimation: Animation {
    
    public var delay: TimeInterval {
        return keyframes.delay
    }
    
    public var duration: TimeInterval {
        return keyframes.timeInterval - delay
    }
    
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
    public let delay: TimeInterval
    public let duration: TimeInterval
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
