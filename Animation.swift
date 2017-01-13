//
//  Animation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

public protocol Animation {
    var duration: TimeInterval { get }
    var delay: TimeInterval { get }
    var animationBlock: AnimationBlock { get }
}

extension Animation {
    
    var timeInterval: TimeInterval {
        return delay + duration
    }
}
