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
    
    case animation(Animation)
    
//    /**
//     Animation operation.
//     
//     - parameter duration: `TimeInterval` to animate over.
//     - parameter delay: `TimeInterval` to delay the animation.
//     - parameter options: `UIViewAnimationOptions` to apply to the animation.
//     - parameter animationBlock: `AnimationBlock` block to perform.
//     */
//    case standard(duration: TimeInterval, delay: TimeInterval, options: UIViewAnimationOptions, animationBlock: AnimationBlock)
//    
//    /**
//     Spring animation operation.
//     
//     - parameter duration: `TimeInterval` to animate over.
//     - parameter delay: `TimeInterval` to delay the animation.
//     - parameter damping: Spring damping to apply to the animation.
//     - parameter velocity: Initial Velocity for the UIView to animate with.
//     - parameter options: `UIViewAnimationOptions` to apply to the animation.
//     - parameter animationBlock: `AnimationBlock` block to perform.
//     */
//    case spring(duration: TimeInterval, delay: TimeInterval, damping: CGFloat, velocity: CGFloat, options: UIViewAnimationOptions, animationBlock: AnimationBlock)
//    
//    /**
//     Keyframe animation operation.
//     
//     - parameter animation: A `KeyframeAnimation` object to perform.
//     */
//    case keyframe(animation: KeyframeAnimation)
//    
//    /**
//     Basic animation operation.
//     
//     - parameter animations: A `BasicAnimation` object to perform.
//     */
//    case basic(animation: BasicAnimation)
    
    /**
     Wait operation.
     
     - parameter timeout: `TimeInterval?` to to resume by if resume is not called by the `Wait` block. Pass in `nil` to disable timeout.
     - parameter block: `Wait` block to pause animations.
     */
    case wait(timeout: TimeInterval?, block: WaitBlock)
    
    /**
     Do operation.
     
     - parameter `DoBlock` block to perform between animations.
     */
    case `do`(block: DoBlock)
}
