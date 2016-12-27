//
//  AnimateOperation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 12/12/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit


/// `enum` of supported animation operations.
public enum AnimateOperation {
    
    /**
     Animation operation.
     
     - parameter _: `TimeInterval` to animate over.
     - parameter _: `TimeInterval` to delay the animation.
     - parameter _: `UIViewAnimationOptions` to apply to the animation.
     - parameter _: `Animation` block to perform.
     */
    case animation(TimeInterval, TimeInterval, UIViewAnimationOptions, Animation)
    
    /**
     Spring animation operation.
     
     - parameter _: `TimeInterval` to animate over.
     - parameter _: `TimeInterval` to delay the animation.
     - parameter _: Spring damping to apply to the animation.
     - parameter _: Initial Velocity for the UIView to animate with.
     - parameter _: `UIViewAnimationOptions` to apply to the animation.
     - parameter _: `Animation` block to perform.
     */
    case spring(TimeInterval, TimeInterval, CGFloat, CGFloat, UIViewAnimationOptions, Animation)
    
    /**
     Keyframe animation operation.
     
     - parameter _: `UIViewKeyframeAnimationOptions` to apply to the animation.
     - parameter _: Array of `Keyframe` objects to perform. 
     */
    case keyframe(UIViewKeyframeAnimationOptions, [Keyframe])
    
    /**
     Wait operation.
     
     - parameter _: `TimeInterval?` to to resume by if resume is not called by the `Wait` block. Pass in `nil` to disable timeout.
     - parameter _: `Wait` block to pause animations.
     */
    case wait(TimeInterval?, Wait)
    
    /**
     Do operation.
     
     - parameter _: `Do` block to perform between animations.
     */
    case `do`(Do)
}
