//
//  Array+Extensions.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/12/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

//extension Collection where Iterator.Element == AnimateOperation {
//    
//    var timeInterval: TimeInterval? {
//        var total: TimeInterval = 0.0
//        
//        for operation in self {
//            
//            switch operation {
//            case .animation(let animation):
//                if animation.timeInterval > total { total = animation.timeInterval }
//                
//            case .wait(timeout: let timeout, _):
//                guard let timeout = timeout else { return nil }
//                if timeout > total { total = timeout }
//                
//            case .do: break
//            }
//        }
//
//        return total
//    }
//}

extension Collection where Iterator.Element: Animation, SubSequence.Iterator.Element == Iterator.Element {
    
    var timeInterval: TimeInterval {
        var total = 0.0
        
        for animation in self {
            let animationTotal = animation.duration + animation.delay
            if animationTotal > total { total = animationTotal }
        }

        return total
    }
    
    var delay: TimeInterval {
        var delay = first?.delay ?? 0.0
        
        for animation in self.dropFirst() {
            if animation.delay < delay { delay = animation.delay }
        }
        
        return delay
    }
}
