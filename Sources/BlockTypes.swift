//
//  BlockTypes.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

/// Block containing standard animations to perform.
public typealias AnimationBlock = (Void)->Void

/// Block to be called from a `WaitBlock` that tells the animation to resume execution. It is safe to use with a timeout and can only be called once.
public typealias ResumeBlock = (Void)->Void

/// Block that contains code that an animation should be paused for. It gets passed a `ResumeBlock` that must be called to resume the animation.
public typealias WaitBlock = (_ resume: @escaping ResumeBlock)->Void

/// Block that gets called between animations.
public typealias DoBlock = (Void)->Void


@objc class Block: NSObject {
    
    private struct Static {
        fileprivate static var instances: [Block] = []
    }
    
    var completion: (()->Void)?
    
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

@objc class Wait: Block {

    init(timeout: TimeInterval? = nil, _ completion: @escaping ()->Void = {_ in}) {
        
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
