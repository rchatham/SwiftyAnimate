//
//  Transform.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 1/4/17.
//  Copyright © 2017 Reid Chatham. All rights reserved.
//

import Foundation

/// A view transform.
public enum Transform {
    
    /// `Transform` case for translating a view.
    case move(x: CGFloat, y: CGFloat)
    
    /// `Transform` case for rotating a view.
    case rotate(angle: CGFloat)
    
    /// `Transform` case for scaling a view.
    case scale(x: CGFloat, y: CGFloat)
}
