//
//  Animate.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 10/17/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit


/**
 Composable animations in Swift.
 
 Have fun animating!
 */
open class Animate {
    
    /**
     Creates an animation instance
     
     - returns: An empty animation instance.
     */
    public init() {}
    
    /**
     Creates an animation instance with an initial animation.
     ```
     // syntax:
     
     let animation = Animate(duration: time) {
        // stuff to animate
     }
     
     animation.perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: An animation instance.
     
     */
    convenience public init(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        self.init(animation: StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock))
    }
    
    /**
     Creates an animation instance with an initial spring animation.
     ```
     // syntax:
     
     let animation = Animate(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
         // spring animation
     }
     
     animation.perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter springDamping: Takes the spring damping for the animation. 1.0 gives a smooth animation with a number closer to 0.0 having higher oscillation.
     - parameter initialVelocity: The initial velocity for the view as a ratio of it's distance to it's final position in points per second. If the distance is 200 points then an initial velocity of 0.5 would be 100 points per second.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: An animation instance.
     */
    convenience public init(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        self.init(animation: SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock))
    }
    
    /**
     Creates an animation instance with an initial keyFrame animation.
     ```
     // syntax:
     
     Animate(keyFrames: [
             KeyFrame(duration: 1.0) {
                 // key frame animation
             },
             KeyFrame(duration: 1.0, delay: 0.5) {
                 // key frame animation
             },
             KeyFrame(duration: 1.5) {
                 // key frame animation
             }
         ])
         .perform()
     ```
     
     - parameter keyframes: An array of `Keyframe` objects representing the keyframes to be animated.
     - parameter options: The `UIViewKeyframeAnimationOptions` to be applied to the animation.
     
     - returns: An animation instance.
     */
    convenience public init(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) {
        self.init(animation: KeyframeAnimation(keyframes: keyframes, options: options))
    }
    
    /**
     Creates an animation instance with an initial standard animation.
     ```
     // syntax:
     
     Animate(animation: animation).perform()
     ```
     
     - parameter animation: Takes a `Animation` object.
     
     - returns: An animation instance.
     */
    public init(animation: Animation) {
        operations.enqueue(data: [.animation(animation)])
    }
    
    /**
     Follows the previous animation with a standard animation to the instance.
     ```
     // syntax:
     
     Animate(duration: time) {
            // Initial animation
         }
         .then(duration: time) {
            // Animation begining upon completion of the initial animation.
         }
         .then(duration: time) {
            // Animation following the previous animation.
         }
         .perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        return then(animation: StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock))
    }
    
    /**
     Follows the previous animation with a spring animation to the instance.
     ```
     // syntax:
     
     Animate()
         .then(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
             // spring animation
         }
         .then(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
             // spring animation
         }
         .perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter springDamping: Takes the spring damping for the animation. 1.0 gives a smooth animation with a number closer to 0.0 having higher oscillation.
     - parameter initialVelocity: The initial velocity for the view as a ratio of it's distance to it's final position in points per second. If the distance is 200 points then an initial velocity of 0.5 would be 100 points per second.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        return then(animation: SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock))
    }
    
    /**
     Follows the previous animation with a keyFrame animation to the instance.
     ```
     // syntax:
     
     Animate()
         .then(keyFrames: [
             KeyFrame(duration: 1.0) {
                 // key frame animation
             },
             KeyFrame(duration: 1.0, delay: 0.5) {
                 // key frame animation
             },
             KeyFrame(duration: 1.5) {
                 // key frame animation
             }
         ])
         .perform()
     ```
     
     - parameter keyframes: An array of `Keyframe` objects representing the keyframes to be animated.
     - parameter options: The `UIViewKeyframeAnimationOptions` to apply to the animation.
     
     - returns: The current animation instance.
     */
    open func then(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) -> Animate {
        return then(animation: KeyframeAnimation(keyframes: keyframes, options: options))
    }
    
    /**
     Follows the previous animation with a standard animation added to the instance.
     ```
     // syntax:
     
     Animate()
         .then(animation: standard)
         .perform()
     ```
     
     - parameter animation: Takes a `Animation` object.
     
     - returns: The current animation instance.
     */
    open func then(animation: Animation) -> Animate {
        operations.enqueue(data: [.animation(animation)])
        return self
    }
    
    /**
     Appends the passed `Animate` instance to the current animation.
     ```
     // syntax:
     
     let animation = Animate(duration: time) {
             // animation code
         }
     
     Animate(duration: time) {
             // initial animation
         }
         .then(animation: animation)
         .perform()
     ```
     
     - parameter animation: `Animate` instance to append.
     
     - returns: The current animation instance.
     */
    open func then(animation: Animate) -> Animate {
        let animation = animation.copy
        let operation = AnimateOperation.wait(timeout: nil) { resume in animation.perform { resume() } }
        operations.enqueue(data: [operation])
        return self
    }
    
    /**
     Adds a standard animation to the instance.
     ```
     // syntax:
     
     Animate(duration: time) {
             // Initial animation
         }
         .and(duration: time) {
             // Animation begining upon completion of the initial animation.
         }
         .and(duration: time) {
             // Animation following the previous animation.
         }
         .perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     */
    open func and(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        return and(animation: StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock))
    }
    
    /**
     Adds a spring animation to the instance.
     ```
     // syntax:
     
     Animate(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
             // spring animation
         }
         .and(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
             // spring animation
         }
         .perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter springDamping: Takes the spring damping for the animation. 1.0 gives a smooth animation with a number closer to 0.0 having higher oscillation.
     - parameter initialVelocity: The initial velocity for the view as a ratio of it's distance to it's final position in points per second. If the distance is 200 points then an initial velocity of 0.5 would be 100 points per second.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     */
    open func and(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        return and(animation: SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock))
    }
    
    /**
     Adds a keyFrame animation to the instance.
     ```
     // syntax:
     
     Animate(duration: time) {
             // Initial animation
         }
         .and(keyframes: [
             KeyFrame(duration: 1.0) {
                 // key frame animation
             },
             KeyFrame(duration: 1.0, delay: 0.5) {
                 // key frame animation
             },
             KeyFrame(duration: 1.5) {
                 // key frame animation
             }
         ])
         .perform()
     ```
     
     - parameter keyframes: An array of `Keyframe` objects representing the keyframes to be animated.
     - parameter options: The `UIViewKeyframeAnimationOptions` to apply to the animation.
     
     - returns: The current animation instance.
     */
    open func and(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) -> Animate {
        return and(animation: KeyframeAnimation(keyframes: keyframes, options: options))
    }
    
    /**
     Adds a standard animation to the instance.
     ```
     // syntax:
     
     Animate(duration: time) {
             // Initial animation
         }
         .and(animation: standard)
         .perform()
     ```
     
     - parameter animation: A `Animation` object representing a standard animation.
     
     - returns: The current animation instance.
     */
    open func and(animation: Animation) -> Animate {
        
        switch operations.last {
        case .some:
            operations.last!.data.append(.animation(animation))
        case .none:
            operations.enqueue(data: [.animation(animation)])
        }
        
        return self
    }
    
    /**
     Adds an animation to the instance in parallel to the top animations.
     ```
     // syntax:
     
     let animation = Animate(duration: time) {
         // Initial animation
     }
     
     Animate(duration: time) {
             // Initial animation
         }
         .and(animation: animation)
         .perform()
     ```
     
     - parameter basicAnimation: Takes a `BasicAnimation` object.
     
     - returns: The current animation instance.
     */
    open func and(animation: Animate) -> Animate {
        
        let animation = animation.copy
        let operation = AnimateOperation.wait(timeout: nil) { resume in animation.perform { resume() } }
        
        switch operations.last {
        case .some:
            operations.last!.data.append(operation)
        case .none:
            operations.enqueue(data: [operation])
        }
        
        return self
    }
    
    /**
     Block in which to perform things that you may want to pause an ongoing flow of animations for.
     ```
     // syntax:
     
     Animate(duration: time) {
             // Perform animations
         }
         .wait { (resume: ResumeBlock) in
             // Perform operations that take time or a function with a callback.
             // ...
             // ...
             // ...
             // After some time has passed.
             resume()
             
             // ...
             // Or once something has finished.
             function(callback: {
                 resume()
             })
         }
         .then(duartion: time) {
             // Perform more animations
         }
         .perform()
     ```
     
     - parameter waitBlock: a `WaitBlock` block consisting of a function which is passed to the user. This must be called in order to resume any further animations passed in after the wait block.
     
     - returns: The current animation instance.
     
     - warning: You must remember to call the resume block if no timeout has been passed in or further animations will not occur and it will result in a memory leak!
     */
    open func wait(timeout: TimeInterval? = nil, waitBlock: @escaping WaitBlock = {_ in}) -> Animate {
        operations.enqueue(data: [.wait(timeout: timeout, block: waitBlock)])
        return self
    }
    
    /**
     Block in which to perform non animation code which should occur between specified animations.
     
     ```
     // syntax:
     
     Animate(duration: time) {
             // initial animations
         }
         .do {
             // non-animation code
         }
         .then(duration: time) {
             // more animations
         }
         .do {
             // more non-animation code
         }
         .perform()
     ```
     
     - parameter block: `DoBlock` block to perform after an animation completes.
     
     - returns: The current animation instance.
     */
    open func `do`(block: @escaping DoBlock) -> Animate {
        operations.enqueue(data: [.do(block: block)])
        return self
    }
    
    /**
     Method call to start or perform animations. Takes a closure that gets called after the last animation.
     ```
     // syntax:
     
     let animation = Animate(duration: time) {
            // Initial animation.
         }
         .then(duration: time) {
            // More animations
         }
         .wait {
            // For something to happen
            resume()
         }
         .then(duraton: time) {
            // Finishing animation
         }
     
     // Nothing will occur until calling perform on the animation instance.
     
     animation.perform()
     ```
     
     - parameter completion: Called after the final animation completes.
     */
    open func perform(completion: @escaping (()->Void) = {}) {
        
        guard let operationSet = operations.dequeue() else { return completion() }
        
        let group = DispatchGroup()
        
        // Perform operations
        for operation in operationSet {
            
            group.enter()
        
            switch operation {
            case .animation(let animation):
                
                animation.performAnimations(completion: { (success) in
                    group.leave()
                })
                
            case .wait(let timeout, let waitBlock):
                
                let wait = Wait(timeout: timeout, group.leave)
                
                waitBlock({ [weak self] in
                    wait.complete(self as Any)
                })
                
            case .do(let doBlock):
                
                doBlock()
                group.leave()
            }
        }
        
        // Keep a strong reference to ensure the Animate instance does not get deallocated unexpectedly.
        group.notify(queue: .main) {
            self.perform(completion: completion)
        }
        
    }
    
    /**
     Adds a finishing animation and then immediately calls perform on the animation instance.
     ```
     // syntax:
     
     Animate(duration: time) {
             // Perform initial animation
         }
         .finish(duration: time) {
             // Perform finishing animation
         }
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     */
    open func finish(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        _ = then(duration: duration, delay: delay, options: options, animationBlock: animationBlock)
        perform()
    }
    
    /**
     Adds a finishing animation and then immediately calls perform on the animation instance.
     ```
     // syntax:
     
     Animate(duration: time) {
             // Perform initial animation
         }
         .finish(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
             // Perform finishing animation
         }
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter springDamping: Takes the spring damping for the animation. 1.0 gives a smooth animation with a number closer to 0.0 having higher oscillation.
     - parameter initialVelocity: The initial velocity for the view as a ratio of it's distance to it's final position in points per second. If the distance is 200 points then an initial velocity of 0.5 would be 100 points per second.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is an empty array.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     */
    open func finish(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        _ = then(duration: duration, delay: delay, springDamping: springDamping, initialVelocity: initialVelocity, options: options, animationBlock: animationBlock)
        perform()
    }
    
    /**
     Follows the previous animation with a keyframe animation and calls perform on the instance.
     ```
     // syntax:
     
     Animate()
         .finish(keyframes: [
             KeyFrame(duration: 1.0) {
                 // key frame animation
             },
             KeyFrame(duration: 1.0, delay: 0.5) {
                 // key frame animation
             },
             KeyFrame(duration: 1.5) {
                 // key frame animation
             }
         ])
     ```
     
     - parameter keyframes: An array of `Keyframe` objects representing the keyframes to be animated.
     - parameter options: The `UIViewKeyframeAnimationOptions` to apply to the animation.
     
     - returns: The current animation instance.
     */
    open func finish(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) {
        _ = then(keyframes: keyframes, options: options)
        perform()
    }
    
    /**
     Follows the previous animation with a standard animation and calls perform on the instance.
     ```
     // syntax:
     
     Animate().finish(animation: standard)
     ```
     
     - parameter animation: Takes a `Animation` object.
     */
    open func finish(animation: Animation) {
        _ = then(animation: animation)
        perform()
    }
    
    /**
     Appends the passed `Animate` instance to the current animation and then performs it. The animation instance passed in is discarded to prevent memory leaks.
     ```
     // syntax:
     
     let animation = Animate(duration: time) {
         // animation code
     }
     
     Animate(duration: time) {
             // initial animation
         }
         .finish(animation: animation)
     ```
     
     - parameter animation: `Animate` instance to append.
     */
    open func finish(animation: Animate) {
        _ = then(animation: animation)
        perform()
    }
    
    /**
     Dequeues the animation instance without performing any of the remaining animations.
     */
    open func decay() {
        operations.release()
    }
    
    // MARK: - Fileprivate
    
    fileprivate var operations = Queue<[AnimateOperation]>()
    
}

extension Animate: NSCopying {
    
    /// Copies the current Animate instance.
    /// - parameter zone: Optional `NSZone` to copy with. Default is `nil`. Does not have any effect when copying with `Animate`.
    /// - returns: A new instance with the same animations as the original.
    open func copy(with zone: NSZone? = nil) -> Any {
        let animation = Animate()
        animation.operations = operations.copy
        return animation
    }
    
    /// Copy of the current instance.
    /// - returns: A new `Animate` instance with matching animations.
    open var copy: Animate {
        return copy() as! Animate
    }
}
