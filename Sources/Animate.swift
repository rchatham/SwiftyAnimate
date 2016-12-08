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
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     
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
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    public init(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animations: @escaping Animation) {
        self.animations.enqueue(data: .spring(duration, delay, springDamping, initialVelocity, options, animations))
    }
    
    /**
     Perform linked animations here.
     ```
     //syntax:
     
     Animate(duration: time) {
        // Initial animation
     
     }.then(duration: time) {
        // Animation begining upon completion of the initial animation.
     
     }.then(duration: time) {
        // Animation following the previous animation.
     
     }.perform()
     ```
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], animations: @escaping Animation) -> Animate {
        self.animations.enqueue(data: .animation(duration,delay,options,animations))
        return self
    }
    
    /**
     Perform linked spring animations here.
     ```
     //syntax:
     
     Animate(duration: time) {
         // Animation begining upon completion of the initial animation.
     
     }.then(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
         // spring animation
     
     }.then(duration: time, delay: 1.0, options: [.curveEaseInOut]) {
         // Animation following the previous animation.
     
     }.perform()
     ```
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter springDamping: Takes the spring damping for the animation. 1.0 gives a smooth animation with a number closer to 0.0 having higher oscillation.
     - parameter initialVelocity: The initial velocity for the view as a ratio of it's distance to it's final position in points per second. If the distance is 200 points then an initial velocity of 0.5 would be 100 points per second.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func then(duration: TimeInterval, delay: TimeInterval = 0.0, springDamping: CGFloat, initialVelocity: CGFloat, options: UIViewAnimationOptions = [], animations: @escaping Animation) -> Animate {
        self.animations.enqueue(data: .spring(duration, delay, springDamping, initialVelocity, options, animations))
        return self
    }
    
    /**
     Appends the passed `Animate` instance to the current animation.
     ```
     //syntax:
     
     let animation = Animate(duration: time) {
         // animation code
     }
     
     Animate(duration: time, springDamping: 0.8, initialVelocity: 0.0) {
         // initial animation
     }.then(animation: animation).perform()
     ```
     
     - parameter animation: `Animate` instance to append.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func then(animation: Animate) -> Animate {
        animations.append(animation.animations)
        return self
    }
    
    /**
     Block in which to perform things that you may want to pause an ongoing flow of animations for.
     ```
     //syntax:
     
     Animate(duration: time) {
        // Perform animations
     
     }.wait { (resume: ()->Void) in
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
     
     }.then(duartion: time) {
        // Perform more animations
     
     }.perform()
     ```
     - parameter callback: a `Wait` block consisting of a function which is passed to the user. This must be called in order to resume any further animations passed in after the wait block.
     
     - returns: The current animation instance.
     
     - warning: You must remember to call the resume block if no timeout has been passed in or further animations will not occur and it will result in the nimation instance not being deallocated properly!
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func wait(timeout: TimeInterval? = nil, callback: @escaping Wait) -> Animate {
        animations.enqueue(data: .wait(timeout, callback))
        return self
    }
    
    /**
     Block in which to perform non animation code which should occur between specified animations.
     
     ```
     // syntax:
     
     Animate(duration: time) {
        // initial animations
     }.do {
        // non-animation code
     }.then(duration: time) {
        // more animations
     }.do {
        // more non-animation code
     }.perform()
     ```
     
     - parameter callback: `Do` block to perform after an animation completes.
     
     - returns: The current animation instance.
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func `do`(callback: @escaping Do) -> Animate {
        animations.enqueue(data: .do(callback))
        return self
    }
    
    /**
     Method call to start or perform animations. Takes a closure that gets called after the last animation.
     ```
     //syntax:
     
     let animation = Animate(duration: time) {
        // Initial animation.
     }.then(duration: time) {
        // More animations
     }.wait {
        // For something to happen
        resume()
     }.then(duraton: time) {
        // Finishing animation
     }
     
     // Nothing will occur until calling perform on the animation instance.
     
     animation.perform()
     ```
     - parameter completion: Called after the final animation completes.
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func perform(completion: @escaping (Void)->Void = {_ in}) {
        
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
     }.finish(duration: time) {
        // Perform finishing animation
     }
     ```
     - parameter duration: The duration that the animation should take.
     - parameter delay: Takes a time interval to delay the animation.
     - parameter options: Takes a set of UIViewAnimationOptions. Default is none.
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func finish(duration: TimeInterval, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], _ callback: @escaping Animation) {
        animations.enqueue(data: .animation(duration,delay,options,callback))
        perform()
    }
    
    /**
     Dequeues the animation instance without performing any of the remaining animations.
     
     - warning: Not calling decay, finish or perform on an animation will result in the nimation instance not being deallocated properly!
     */
    open func decay() {
        guard animations.dequeue() != nil else { return }
        decay()
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
