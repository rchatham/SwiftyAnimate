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
