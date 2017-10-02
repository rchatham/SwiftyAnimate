//
//  BlockTypes.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

/// Block containing standard animations to perform.
public typealias AnimationBlock = ()->Void

/// Block to be called from a `WaitBlock` that tells the animation to resume execution. It is safe to use with a timeout and can only be called once.
public typealias ResumeBlock = ()->Void

/// Block that contains code that an animation should be paused for. It gets passed a `ResumeBlock` that must be called to resume the animation.
public typealias WaitBlock = (_ resume: @escaping ResumeBlock)->Void

/// Block that gets called between animations.
public typealias DoBlock = ()->Void


class Block: NSObject {
    
    private struct Static {
        fileprivate static var instances: [Block] = []
    }
    
    private var completion: (()->Void)?
    
    init(_ completion: @escaping ()->Void) {
        self.completion = completion
        super.init()
        Static.instances.append(self)
    }
    
    @objc func complete(_ sender: Any) {
        completion?()
        completion = nil
        Static.instances = Static.instances.filter { $0 !== self }
    }
    
}

class Wait: Block {

    init(timeout: TimeInterval? = nil, _ completion: @escaping ()->Void = {}) {
        
        var timer: Timer?
        
        super.init() {
            completion()
            timer?.invalidate()
        }
        
        if let timeout = timeout {
            if #available(iOS 10.0, *) {
                timer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { [weak self] (timer) in
                    self?.complete(timer)
                }
            } else {
                timer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(Wait.complete(_:)), userInfo: nil, repeats: false)
            }
        }
    }
}

class BasicAnimationBlock: Block {
    
    private var animationBlock: AnimationBlock?
    
    @discardableResult init(duration: TimeInterval, delay: TimeInterval, animationBlock: @escaping AnimationBlock, completion:  ((Bool)->Void)? = nil) {
        self.animationBlock = animationBlock
        super.init {
            completion?(true)
        }
        
        // Animation
        if delay == 0.0 {
            animationBlock()
        } else {
            if #available(iOS 10.0, *) {
                Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { [weak self] (timer) in
                    self?.animationBlock(timer)
                })
            } else {
                Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(BasicAnimationBlock.animationBlock(_:)), userInfo: nil, repeats: false)
            }
        }
        
        // Completion
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: duration + delay, repeats: false, block: { [weak self] (timer) in
                self?.complete(timer)
            })
        } else {
            Timer.scheduledTimer(timeInterval: duration + delay, target: self, selector: #selector(BasicAnimationBlock.complete(_:)), userInfo: nil, repeats: false)
        }
    }
    
    @objc func animationBlock(_ sender: Timer) {
        animationBlock?()
        animationBlock = nil
    }
}
