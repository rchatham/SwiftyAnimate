//
//  Animate.swift
//  VogueStore
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
public enum Operation {
    /** 
     Animation operation.
     
     - parameter _: `TimeInterval` to animate over.
     - parameter _: `Animation` block to perform.
     */
    case animation(TimeInterval, Animation)
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
    
    private var animations = Queue<Operation>()
    
    /**
     Creates an animation instance
     
     - returns: An empty animation instance.
     */
    public init() {}
    
    /**
     Creates an animation instance with an initial animation.
     ```
     //syntax:
     
     let time = 0.5
     
     let animation = Animate(duration: time) {
        // Stuff to animate
     }
     
     animation.perform()
     ```
     - parameter duration: The duration that the animation should take.
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: An animation instance.
     
     - warning: Not calling finish or perform on an animation will result in a memory leak!
     
     */
    public init(duration: TimeInterval, _ callback: @escaping Animation) {
        animations.enqueue(data: .animation(duration,callback))
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
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - returns: The current animation instance.
     
     - warning: Not calling finish or perform on an animation will result in a memory leak!
     
     */
    open func then(duration: TimeInterval, _ callback: @escaping Animation) -> Animate {
        animations.enqueue(data: .animation(duration,callback))
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
     
     - warning: You must remember to call the resume block if no timeout has been passed in or further animations will not occur and it will result in a memory leak!
     - warning: Not calling finish or perform on an animation will result in a memory leak!
     
     */
    open func wait(timeout: TimeInterval? = nil, _ callback: @escaping Wait) -> Animate {
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
     
     - warning: Not calling finish or perform on an animation will result in a memory leak!
     */
    open func `do`(_ callback: @escaping Do) -> Animate {
        animations.enqueue(data: .do(callback))
        return self
    }
    
    /**
     Block in which to perform things that you may want to pause an ongoing flow of animations for.
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
     
     - warning: Not calling finish or perform on an animation will result in a memory leak!
     */
    open func perform(completion: (Void)->Void = {_ in}) {
        guard let operation = animations.dequeue() else { return completion() }
        switch operation {
        case .animation(let duration, let animation):
            UIView.animate(withDuration: duration, animations: animation) { success in
                self.perform()
            }
        case .wait(let timeout, let callback):
            var timedout = false
            callback {
                if !timedout {
                    timedout = true
                    self.perform()
                }
            }
            guard let timeout = timeout else { return }
            Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { timer in
                if !timedout {
                    timedout = true
                    self.perform()
                }
            }
        case .do(let callback):
            callback()
            perform()
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
     - parameter callback: `Animation` callback to perform over the duration passed in.
     
     - warning: Not calling finish or perform on an animation will result in a memory leak!
     */
    open func finish(duration: TimeInterval, _ callback: @escaping Animation) {
        animations.enqueue(data: .animation(duration, callback))
        perform()
    }
    
    /**
     Destroys an animation instance without performing any of the remaining animations.
     */
    open func destroy() {
        guard animations.dequeue() != nil else { return }
        destroy()
    }
}
