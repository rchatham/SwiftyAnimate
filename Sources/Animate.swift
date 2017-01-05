//
//  Animate.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 10/17/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit

/// `Animation` block `(Void)->Void`
public typealias Animation = (Void)->Void
/// `Resume` block to be called from a `Wait` block `(Void)->Void`
public typealias Resume = (Void)->Void
/// `Wait` block `(Resume)->Void`
public typealias Wait = (_ resume: @escaping Resume)->Void
/// `Do` block `(Void)->Void`
public typealias Do = (Void)->Void


/**
 Swift animation.
 
 Light wrapper over the `UIView` animation pyramid of doom.
 
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
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     
     */
    public init(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animations: @escaping Animation) {
        self.animations.enqueue(data: .animation(duration,delay,options,animations))
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
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animations: @escaping Animation) {
        self.animations.enqueue(data: .spring(duration, delay, springDamping, initialVelocity, options, animations))
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
     
     - parameter options: Takes a set of `UIViewKeyframeAnimationOptions`.
     - parameter keyframes: An array of Keyframe objects representing the keyframes to be animated.
     
     - returns: An animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    public init(options: UIViewKeyframeAnimationOptions = [], keyframes: [Keyframe]) {
        animations.enqueue(data: .keyframe(options, keyframes))
    }
    
    /**
     Adds a standard animation to the instance.
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
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animations: @escaping Animation) -> Animate {
        self.animations.enqueue(data: .animation(duration,delay,options,animations))
        return self
    }
    
    /**
     Adds a spring animation to the instance.
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
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animations: @escaping Animation) -> Animate {
        self.animations.enqueue(data: .spring(duration, delay, springDamping, initialVelocity, options, animations))
        return self
    }
    
    /**
     Adds a keyFrame animation to the instance.
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
     
     - parameter options: Takes a set of `UIViewKeyframeAnimationOptions`.
     - parameter keyframes: An array of Keyframe objects representing the keyframes to be animated.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(options: UIViewKeyframeAnimationOptions = [], keyframes: [Keyframe]) -> Animate {
        animations.enqueue(data: .keyframe(options, keyframes))
        return self
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
         .then(animation: animation)
         .perform()
     ```
     
     - parameter animation: `Animate` instance to append.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func then(animation: Animate) -> Animate {
        animations.append(animation.animations)
        animation.decay()
        return self
    }
    
    /**
     Block in which to perform things that you may want to pause an ongoing flow of animations for.
     ```
     //syntax:
     
     Animate(duration: time) {
            // Perform animations
         }
         .wait { (resume: ()->Void) in
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
     
     - parameter callback: a `Wait` block consisting of a function which is passed to the user. This must be called in order to resume any further animations passed in after the wait block.
     
     - returns: The current animation instance.
     
     - warning: You must remember to call the resume block if no timeout has been passed in or further animations will not occur and it will result in a memory leak!
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func wait(timeout: TimeInterval? = nil, _ callback: @escaping Wait = {_ in}) -> Animate {
        animations.enqueue(data: .wait(timeout, callback))
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
     
     - parameter callback: `Do` block to perform after an animation completes.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func `do`(_ callback: @escaping Do) -> Animate {
        animations.enqueue(data: .do(callback))
        return self
    }
    
    /**
     Method call to start or perform animations. Takes a closure that gets called after the last animation.
     ```
     //syntax:
     
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
        
        guard let operation = animations.dequeue() else { return completion() }
        
        switch operation {
        case .animation(let duration, let delay, let options, let animations):
            
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: animations) { success in
                self.perform(completion: completion)
            }
            
        case .spring(let duration, let delay, let damping, let velocity, let options, let animations):
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: animations) { success in
                self.perform(completion: completion)
            }
            
        case .keyframe(let options, let keyframes):
            
            var total = 0.0
            var delay = 0.0
            
            for keyframe in keyframes {
                let keyTotal = keyframe.duration + keyframe.delay
                if keyTotal > total { total = keyTotal }
                if keyframe.delay < delay { delay = keyframe.delay }
            }
            
            let duration = total - delay
            
            UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
                
                for keyframe in keyframes {
                    
                    let relativeStartTime: Double = {
                        let relativeDelay = keyframe.delay - delay
                        return relativeDelay / duration
                    }()
                    
                    let relativeDuration: Double = {
                       return keyframe.duration / duration
                    }()
                    
                    UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: keyframe.animation)
                }
                
            }) { success in
                self.perform(completion: completion)
            }
            
        case .wait(let timeout, let waitBlock):
            
            // If a timeout was passed in setup a timer.
            var timer: Timer?
            if let timeout = timeout {
                if #available(iOS 10.0, *) {
                    timer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { _ in self.resumeBlock?() }
                } else {
                    timer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(Animate.resumeBlock(_:)), userInfo: nil, repeats: false)
                }
            }
            
            resumeBlock = {
                timer?.invalidate()
                self.perform(completion: completion)
                self.resumeBlock = nil
            }
            // This passes a closure to the waitBlock which is the resume funtion that the developer must call in the waitBlock.
            waitBlock({ [weak self] in
                self?.resumeBlock?()
            })
            
            
        case .do(let doBlock):
            
            doBlock()
            perform(completion: completion)
            
        }
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
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], _ callback: @escaping Animation) {
        self.animations.enqueue(data: .animation(duration,delay,options,callback))
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
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], _ callback: @escaping Animation) {
        self.animations.enqueue(data: .spring(duration, delay, springDamping, initialVelocity, options, callback))
        perform()
    }
    
    /**
     Adds a keyFrame animation and then immediately performs the animation instance.
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
     
     - parameter options: Takes a set of `UIViewKeyframeAnimationOptions`.
     - parameter keyframes: An array of Keyframe objects representing the keyframes to be animated.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func finish(options: UIViewKeyframeAnimationOptions = [], keyframes: [Keyframe]) {
        animations.enqueue(data: .keyframe(options, keyframes))
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
        animations.append(animation.animations)
        animation.decay()
        perform()
    }
    
    /**
     Dequeues the animation instance without performing any of the remaining animations.
     
     - warning: Not calling decay, finish or perform on an animation will result in a memory leak!
     */
    open func decay() {
        animations.release()
    }
    
    // MARK: - Fileprivate
    
    /// :nodoc:
    fileprivate var animations = Queue<AnimateOperation>()
    
    // MARK: - Private
    
    // Below needed for backwards compatibility.
    /// :nodoc:
    private var resumeBlock: Resume?
    /// :nodoc:
    @objc internal func resumeBlock(_ sender: Timer) {
        resumeBlock?()
    }
    
    
    // MARK: - UIView animations
    
    
    /**
     Creates an `Animate` instance that sets the corner radius on the view's CALayer.
     
     - parameter duration: Duration for the transformation.
     - parameter radius: Value for the new corner radius.
     
     - returns: Animate instance.
     */
    public func corner(view: UIView, duration: TimeInterval, timing: Timing, radius: CGFloat) -> Animate {
        
        let corner = view.layer.cornerRadius
        
        return Animate().wait(timeout: duration) { (resume) in
                let animation = CABasicAnimation(keyPath: "cornerRadius")
                                animation.timingFunction = timing.coreAnimationCurve
                animation.toValue = radius
                animation.fromValue = corner
                animation.duration = duration
                view.layer.add(animation, forKey: "corner")
                view.corner(radius: radius)
        }
    }
    
    /**
     Creates an `Animate` instance that sets the view's background color.
     
     - parameter duration: Duration for the transformation.
     - parameter color: Value for the new background color.
     
     - returns: Animate instance.
     */
    public func color(view: UIView, duration: TimeInterval, value: UIColor) -> Animate {
        return Animate(duration: duration) {
            view.color(value)
        }
    }
    
    /**
     Creates an `Animate` instance that performs a scale core graphics transformation on a view.
     
     - parameter duration: Duration for the transformation.
     - parameter x: Value to scale in the x direction.
     - parameter y: Value to scale in the y direction.
     
     - returns: Animate instance.
     */
    public func scale(view: UIView, duration: TimeInterval, x: CGFloat, y: CGFloat) -> Animate {
        return Animate(duration: duration) {
            view.scale(x: x, y: y)
        }
    }
    
    /**
     Creates an `Animate` instance that performs a rotation core graphics transformation on a view.
     
     - parameter duration: Duration for the transformation.
     - parameter angle: Degrees to rotate the view.
     
     - returns: Animate instance.
     */
    public func rotate(view: UIView, duration: TimeInterval, angle: CGFloat) -> Animate {
        return Animate(duration: 0.3) {
            view.rotate(angle: angle)
        }
    }
    
    /**
     Creates an `Animate` instance that performs a translation core graphics transformation on a view.
     
     - parameter duration: Duration for the transformation.
     - parameter x: Value to shift in the x direction.
     - parameter y: Value to shift in the y direction.
     
     - returns: Animate instance.
     */
    public func move(view: UIView, duration: TimeInterval, x: CGFloat, y: CGFloat) -> Animate {
        return Animate(duration: duration) {
            view.move(x: x, y: y)
        }
    }
    
    /**
     Creates an `Animate` object for performing multiple core graphics transformations on a view.
     
     - parameter duration: Duration for the transformation.
     - parameter transforms: Array of transformations to be performed on the view represented by `Transform` enum cases.
     
     - returns: Animate instance.
     */
    public func transform(view: UIView, duration: TimeInterval, transforms: [Transform]) -> Animate {
        return Animate(duration: duration) {
            view.transformed(by: transforms)
        }
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
