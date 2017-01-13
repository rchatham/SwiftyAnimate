//
//  Animation.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

public struct StandardAnimation: Animation {
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let options: UIViewAnimationOptions
    public let animationBlock: AnimationBlock
}
