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
     //syntax:
     
     let animation = Animate(duration: time) {
        // Stuff to animate
     }
     
     animation.perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     
     */
    public init(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        animations.enqueue(data: [.animation(StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock))])
    }
    
    /**
     Creates an animation instance with an initial spring animation.
     ```
     //syntax:
     
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        animations.enqueue(data: [.animation(SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock))])
    }
    
    /**
     Creates an animation instance with an initial keyFrame animation.
     ```
     //syntax:
     
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) {
        animations.enqueue(data: [.animation(KeyframeAnimation(keyframes: keyframes, options: options))])
    }
    
    /**
     Creates an animation instance with an initial standard animation.
     ```
     //syntax:
     
     Animate(standardAnimation: standard).perform()
     ```
     
     - parameter standardAnimation: Takes a `StandardAnimation` object.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(standardAnimation: StandardAnimation) {
        animations.enqueue(data: [.animation(standardAnimation)])
    }
    
    /**
     Creates an animation instance with an initial spring animation.
     ```
     //syntax:
     
     Animate(springAnimation: spring).perform()
     ```
     
     - parameter basicAnimation: Takes a `SpringAnimation` object.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(springAnimation: SpringAnimation) {
        animations.enqueue(data: [.animation(springAnimation)])
    }
    
    /**
     Creates an animation instance with an initial keyFrame animation.
     ```
     //syntax:
     
     let keyframes = [
         KeyFrame(duration: 1.0) {
             // key frame animation
         },
         KeyFrame(duration: 1.0, delay: 0.5) {
             // key frame animation
         },
         KeyFrame(duration: 1.5) {
             // key frame animation
         }
     ]
     
     let keyframe = KeyframeAnimation(keyframes: keyframe, options: [])
     
     Animate(keyframe: keyframe).perform()
     ```
     
     - parameter keyframe: A `KeyframeAnimation` object representing the keyframes to be animated.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(keyframe: KeyframeAnimation) {
        animations.enqueue(data: [.animation(keyframe)])
    }
    
    /**
     Creates an animation instance with an initial basic animation.
     ```
     //syntax:
     
     let aView = UIView()
     
     let basic = BasicAnimation.cornerRadius(view: aView, duration: 1.0, delay: 0.0, radius: 10.0, timing: .easeInOut)
     
     Animate(basicAnimation: basic).perform()
     ```
     
     - parameter basicAnimation: Takes a `BasicAnimation` object.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(basicAnimation: BasicAnimation) {
        self.animations.enqueue(data: [.animation(basicAnimation)])
    }
    
    /**
     Follows the previous animation with a standard animation to the instance.
     ```
     //syntax:
     
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        self.animations.enqueue(data: [.animation(StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock))])
        return self
    }
    
    /**
     Follows the previous animation with a spring animation to the instance.
     ```
     //syntax:
     
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        self.animations.enqueue(data: [.animation(SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock))])
        return self
    }
    
    /**
     Follows the previous animation with a keyFrame animation to the instance.
     ```
     //syntax:
     
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
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) -> Animate {
        animations.enqueue(data: [.animation(KeyframeAnimation(keyframes: keyframes, options: options))])
        return self
    }
    
    /**
     Follows the previous animation with a standard animation added to the instance.
     ```
     //syntax:
     
     Animate()
         .then(standardAnimation: standard)
         .perform()
     ```
     
     - parameter standardAnimation: Takes a `StandardAnimation` object.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(standardAnimation: StandardAnimation) -> Animate {
        animations.enqueue(data: [.animation(standardAnimation)])
        return self
    }
    
    /**
     Follows the previous animation with a spring animation added to the instance.
     ```
     //syntax:
     
     Animate()
         .then(springAnimation: spring)
         .perform()
     ```
     
     - parameter springAnimation: Takes a `SpringAnimation` object.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(springAnimation: SpringAnimation) -> Animate {
        animations.enqueue(data: [.animation(springAnimation)])
        return self
    }
    
    /**
     Follows the previous animation with a keyFrame animation added to the instance.
     ```
     //syntax:
     
     let keyframes = [
         KeyFrame(duration: 1.0) {
             // key frame animation
         },
         KeyFrame(duration: 1.0, delay: 0.5) {
             // key frame animation
         },
         KeyFrame(duration: 1.5) {
             // key frame animation
         }
     ]
     
     let keyframe = KeyframeAnimation(keyframes: keyframe, options: [])
     
     Animate()
        .then(keyframe: keyframe)
         .perform()
     ```
     
     - parameter keyframe: A `KeyframeAnimation` object representing the keyframes to be animated.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(keyframe: KeyframeAnimation) -> Animate {
        animations.enqueue(data: [.animation(keyframe)])
        return self
    }
    
    /**
     Follows the previous animation with a basic animation added to the instance.
     ```
     //syntax:
     
     let aView = UIView()
     
     let basic = BasicAnimation.cornerRadius(view: aView, duration: 1.0, delay: 0.0, radius: 10.0, timing: .easeInOut)
     
     Animate()
        .then(basicAnimations: basic)
        .perform()
     ```
     
     - parameter basicAnimation: Takes a `BasicAnimation` object.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(basicAnimation: BasicAnimation) -> Animate {
        animations.enqueue(data: [.animation(basicAnimation)])
        return self
    }
    
    /**
     Adds a standard animation to the instance.
     ```
     //syntax:
     
     Animate(duration: time) {
             // Initial animation
         }
         .add(duration: time) {
             // Animation begining upon completion of the initial animation.
         }
         .add(duration: time) {
             // Animation following the previous animation.
         }
         .perform()
     ```
     
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter animationBlock: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func add(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        
        switch self.animations.last {
        case .some:
            self.animations.last!.data.append(.animation(StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock)))
        case .none:
            self.animations.enqueue(data: [.animation(StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock))])
        }
        
        return self
    }
    
    /**
     Adds a spring animation to the instance.
     ```
     //syntax:
     
     Animate(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
             // spring animation
         }
         .add(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func add(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) -> Animate {
        
        switch self.animations.last {
        case .some:
            self.animations.last!.data.append(.animation(SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock)))
        case .none:
            self.animations.enqueue(data: [.animation(SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock))])
        }
        
        return self
    }
    
    /**
     Adds a standard animation to the instance.
     ```
     //syntax:
     
     Animate(duration: time) {
             // Initial animation
         }
         .add(standardAnimation: standard)
         .perform()
     ```
     
     - parameter standardAnimation: A `StandardAnimation` object representing a standard animation.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func add(standardAnimation: StandardAnimation) -> Animate {
        
        switch self.animations.last {
        case .some:
            self.animations.last!.data.append(.animation(standardAnimation))
        case .none:
            self.animations.enqueue(data: [.animation(standardAnimation)])
        }
        
        return self
    }
    
    /**
     Adds a spring animation to the instance.
     ```
     //syntax:
     
     Animate(duration: time) {
             // Initial animation
         }
         .add(springAnimation: spring)
         .perform()
     ```
     
     - parameter springAnimation: A `SpringAnimation` object representing a spring animation.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func add(springAnimation: SpringAnimation) -> Animate {
        
        switch self.animations.last {
        case .some:
            self.animations.last!.data.append(.animation(springAnimation))
        case .none:
            self.animations.enqueue(data: [.animation(springAnimation)])
        }
        
        return self
    }
    
    /**
     Adds a keyFrame animation to the instance.
     ```
     //syntax:
     
     Animate(duration: time) {
             // Initial animation
         }
         .add(keyframe: keyframe)
         .perform()
     ```
     
     - parameter keyframeAnimation: A `KeyframeAnimation` object representing the keyframes to be animated.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func add(keyframeAnimation: KeyframeAnimation) -> Animate {
        
        switch self.animations.last {
        case .some:
            self.animations.last!.data.append(.animation(keyframeAnimation))
        case .none:
            self.animations.enqueue(data: [.animation(keyframeAnimation)])
        }
        
        return self
    }
    
    /**
     Adds a basic animation to the instance.
     ```
     //syntax:
     
     let aView = UIView()
     
     let basic = BasicAnimation.cornerRadius(view: aView, duration: 1.0, delay: 0.0, radius: 10.0, timing: .easeInOut)
     
     Animate(duration: time) {
             // Initial animation
         }
         .add(basicAnimation: basic)
         .perform()
     ```
     
     - parameter basicAnimation: Takes a `BasicAnimation` object.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func add(basicAnimation: BasicAnimation) -> Animate {
        
        switch animations.last {
        case .some:
            animations.last!.data.append(.animation(basicAnimation))
        case .none:
            animations.enqueue(data: [.animation(basicAnimation)])
        }
        
        return self
    }
    
    /**
     Adds a finishing animation and then immediately calls perform on the animation instance.
     ```
     //syntax:
     
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        animations.enqueue(data: [.animation(StandardAnimation(duration: duration, delay: delay, options: options, animationBlock: animationBlock))])
        perform()
    }
    
    /**
     Adds a finishing animation and then immediately calls perform on the animation instance.
     ```
     //syntax:
     
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animationBlock: @escaping AnimationBlock) {
        animations.enqueue(data: [.animation(SpringAnimation(duration: duration, delay: delay, damping: springDamping, velocity: initialVelocity, options: options, animationBlock: animationBlock))])
        perform()
    }
    
    /**
     Follows the previous animation with a keyframe animation and calls perform on the instance.
     ```
     //syntax:
     
     Animate()
         .finish(keyFrames: [
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
     
     - parameter keyframes: A `KeyframeAnimation` objects representing the keyframes to be animated.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(keyframes: [Keyframe], options: UIViewKeyframeAnimationOptions = []) {
        animations.enqueue(data: [.animation(KeyframeAnimation(keyframes: keyframes, options: options))])
        perform()
    }
    
    /**
     Follows the previous animation with a standard animation and calls perform on the instance.
     ```
     //syntax:
     
     Animate().finish(standardAnimation: standard)
     ```
     
     - parameter standardAnimation: Takes a `StandardAnimation` object.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(standardAnimation: StandardAnimation) {
        animations.enqueue(data: [.animation(standardAnimation)])
        perform()
    }
    
    /**
     Follows the previous animation with a spring animation and calls perform on the instance.
     ```
     //syntax:
     
     Animate().finish(springAnimation: spring)
     ```
     
     - parameter springAnimation: Takes a `SpringAnimation` object.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(springAnimation: SpringAnimation) {
        animations.enqueue(data: [.animation(springAnimation)])
        perform()
    }
    
    /**
     Adds a keyFrame animation and then immediately performs the animation instance.
     ```
     //syntax:
     
     let keyframes = [
         KeyFrame(duration: 1.0) {
             // key frame animation
         },
         KeyFrame(duration: 1.0, delay: 0.5) {
             // key frame animation
         },
         KeyFrame(duration: 1.5) {
             // key frame animation
         }
     ]
     
     let keyframe = KeyframeAnimation(keyframes: keyframes, options: [])
     
     Animate().finish(keyframe: keyframe)
     ```
     
     - parameter keyframe: A `KeyframeAnimation` object representing the keyframes to be animated.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(keyframe: KeyframeAnimation) {
        animations.enqueue(data: [.animation(keyframe)])
        perform()
    }
    
    /**
     Follows the previous animation with a basic animation and calls perform on the instance.
     ```
     //syntax:
     
     let aView = UIView()
     
     let basic = BasicAnimation.cornerRadius(view: aView, duration: 1.0, delay: 0.0, radius: 10.0, timing: .easeInOut)
     
     Animate().finish(basicAnimation: basic)
     ```
     
     - parameter basicAnimation: Takes a `BasicAnimation` object.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(basicAnimation: BasicAnimation) {
        animations.enqueue(data: [.animation(basicAnimation)])
        perform()
    }
    
    /**
     Appends the passed `Animate` instance to the current animation and then performs it. The animation instance passed in is discarded to prevent memory leaks.
     ```
     //syntax:
     
     let animation = Animate(duration: time) {
         // animation code
     }
     
     Animate(duration: time) {
             // initial animation
         }
         .finish(animation: animation)
     ```
     
     - parameter animation: `Animate` instance to append.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(animation: Animate) {
        concat(animation: animation).perform()
    }
    
    /**
     Dequeues the animation instance without performing any of the remaining animations.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func decay() {
        animations.release()
    }
    
    /**
     Block in which to perform things that you may want to pause an ongoing flow of animations for.
     ```
     //syntax:
     
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
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func wait(timeout: TimeInterval? = nil, waitBlock: @escaping WaitBlock = {_ in}) -> Animate {
        animations.enqueue(data: [.wait(timeout: timeout, block: waitBlock)])
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func `do`(block: @escaping DoBlock) -> Animate {
        animations.enqueue(data: [.do(block: block)])
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
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func perform(completion: @escaping (()->Void) = {_ in}) {
        
        guard let operations = animations.dequeue() else {
            return completion()
        }
        
        // Completion implementation
        completionBlock = {
            self.completionBlock = nil
            self.perform(completion: completion)
        }
        
        if let total = operations.timeInterval {
            if #available(iOS 10.0, *) {
                Timer.scheduledTimer(withTimeInterval: total, repeats: false) { [weak self] (timer) in
                    self?.completionBlock?()
                }
            } else {
                Timer.scheduledTimer(timeInterval: total, target: self, selector: #selector(Animate.completionBlock(_:)), userInfo: nil, repeats: false)
            }
        }
        
        // Perform operations
        for operation in operations {
        
            switch operation {
            case .animation(let animation):
                
                if let standard = animation as? StandardAnimation {
                    
                    UIView.animate(withDuration: standard.duration, delay: standard.delay, options: standard.options, animations: standard.animationBlock, completion: nil)
                    
                } else if let spring = animation as? SpringAnimation {
                    
                    UIView.animate(withDuration: spring.duration, delay: spring.delay, usingSpringWithDamping: spring.damping, initialSpringVelocity: spring.velocity, options: spring.options, animations: spring.animationBlock, completion: nil)
                    
                } else if let keyframe = animation as? KeyframeAnimation {
                    
                    UIView.animateKeyframes(withDuration: keyframe.duration, delay: keyframe.delay, options: keyframe.options, animations: keyframe.animationBlock, completion: nil)
                    
                } else if let basic = animation as? BasicAnimation {
                    
                    animationBlock = {
                        self.animationBlock = nil
                        basic.animationBlock()
                    }
                    
                    if #available(iOS 10.0, *) {
                        Timer.scheduledTimer(withTimeInterval: basic.delay, repeats: false) { [weak self] (timer) in
                            self?.animationBlock?()
                        }
                    } else {
                        Timer.scheduledTimer(timeInterval: basic.delay, target: self, selector: #selector(Animate.animationBlock(_:)), userInfo: nil, repeats: false)
                    }
                    
                } else {
                    
                    animationBlock = {
                        self.animationBlock = nil
                        animation.animationBlock()
                    }
                    
                    if #available(iOS 10.0, *) {
                        Timer.scheduledTimer(withTimeInterval: animation.delay, repeats: false) { [weak self] (timer) in
                            self?.animationBlock?()
                        }
                    } else {
                        Timer.scheduledTimer(timeInterval: animation.delay, target: self, selector: #selector(Animate.animationBlock(_:)), userInfo: nil, repeats: false)
                    }
                    
                }
                
            case .wait(let timeout, let waitBlock):
                
                // If a timeout was passed in setup a timer.
                var timer: Timer?
                if let timeout = timeout {
                    if #available(iOS 10.0, *) {
                        timer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { (timer) in
                            self.resumeBlock?()
                        }
                    } else {
                        timer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(Animate.resumeBlock(_:)), userInfo: nil, repeats: false)
                    }
                }
                
                resumeBlock = {
                    self.resumeBlock = nil
                    timer?.invalidate()
                    self.completionBlock?()
                }
                // This passes a closure to the waitBlock which is the resume funtion that the developer must call in the waitBlock.
                waitBlock(resumeBlock ?? {})
                
            case .do(let doBlock):
                
                doBlock()
            }
        }
    }
    
    /**
     Appends the passed `Animate` instance to the current animation. The animation instance passed in is discarded to prevent memory leaks.
     ```
     //syntax:
     
     let animation = Animate(duration: time) {
             // animation code
         }
     
     Animate(duration: time) {
             // initial animation
         }
         .concat(animation: animation)
         .perform()
     ```
     
     - parameter animation: `Animate` instance to append.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func concat(animation: Animate) -> Animate {
        animations.append(animation.animations)
        animation.decay()
        return self
    }
    
    // MARK: - Fileprivate
    
    fileprivate var animations = Queue<[AnimateOperation]>()
    
    // MARK: - Private
    
    // Below needed for backwards compatibility.
    
    private var resumeBlock: ResumeBlock?
    @objc internal func resumeBlock(_ sender: Timer) {
        resumeBlock?()
    }
    
    private var animationBlock: AnimationBlock?
    @objc internal func animationBlock(_ sender: Timer) {
        animationBlock?()
    }
    
    private var completionBlock: (()->Void)?
    @objc internal func completionBlock(_ sender: Timer) {
        completionBlock?()
    }
}

extension Animate: NSCopying {
    
    /// Copies the current Animate instance.
    /// - returns: A new instance with the same animations as the original.
    open func copy(with zone: NSZone? = nil) -> Any {
        let animation = Animate()
        animation.animations = animations
        return animation
    }
    
    /// Copy of the current instance.
    /// - returns: A new `Animate` instance with matching animations.
    open var copy: Animate {
        return copy() as! Animate
    }
}
