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
public struct Keyframe {
    let delay: TimeInterval
    let duration: TimeInterval
    let animation: Animation
    
    /**
     Initializes a `Keyframe` struct representing a keyframe animation.
     
     - parameter duration: The length of the keyframe.
     - parameter delay: The length of the delay before the the keyframe.
     - parameter animation: The animation closure to be performed.
     
     - returns: Returns an initialized Keyframe struct.
     */
    public init(duration: TimeInterval, delay: TimeInterval = 0.0, animation: @escaping Animation) {
        self.duration = duration
        self.delay = delay
        self.animation = animation
    }
}
