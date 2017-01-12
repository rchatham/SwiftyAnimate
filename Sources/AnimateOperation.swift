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
     
     - parameter `TimeInterval` to animate over.
     - parameter `TimeInterval` to delay the animation.
     - parameter `UIViewAnimationOptions` to apply to the animation.
     - parameter `Animation` block to perform.
     */
    case animation(TimeInterval, TimeInterval, UIViewAnimationOptions, Animation)
    
    /**
     Spring animation operation.
     
     - parameter `TimeInterval` to animate over.
     - parameter `TimeInterval` to delay the animation.
     - parameter Spring damping to apply to the animation.
     - parameter Initial Velocity for the UIView to animate with.
     - parameter `UIViewAnimationOptions` to apply to the animation.
     - parameter `Animation` block to perform.
     */
    case spring(TimeInterval, TimeInterval, CGFloat, CGFloat, UIViewAnimationOptions, Animation)
    
    /**
     Keyframe animation operation.
     
     - parameter `UIViewKeyframeAnimationOptions` to apply to the animation.
     - parameter Array of `Keyframe` objects to perform.
     */
    case keyframe(UIViewKeyframeAnimationOptions, [Keyframe])
    
    /**
     Wait operation.
     
     - parameter `TimeInterval?` to to resume by if resume is not called by the `Wait` block. Pass in `nil` to disable timeout.
     - parameter `Wait` block to pause animations.
     */
    case wait(TimeInterval?, Wait)
    
    /**
     Do operation.
     
     - parameter `Do` block to perform between animations.
     */
    case `do`(Do)
}
