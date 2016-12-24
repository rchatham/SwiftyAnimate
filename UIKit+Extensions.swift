//
//  UIKit+Extensions.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 12/23/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import Foundation

extension UIView {
    public func move(x: CGFloat, y: CGFloat) {
        transform = CGAffineTransform(translationX: x, y: y)
    }
    
    public func move(duration: TimeInterval, x: CGFloat, y: CGFloat) -> Animate {
        return Animate(duration: duration) { [weak self] in
            self?.move(x: x, y: y)
        }
    }
    
    public func rotate(angle: CGFloat) {
        transform = CGAffineTransform(rotationAngle: angle)
    }
    
    public func rotate(duration: TimeInterval, angle: CGFloat) -> Animate {
        return Animate(duration: 0.3) { [weak self] in
            self?.rotate(angle: angle)
        }
    }
    
    public func scale(x: CGFloat, y: CGFloat) {
        transform = CGAffineTransform(scaleX: x, y: y)
    }
    
    public func scale(duration: TimeInterval, x: CGFloat, y: CGFloat) -> Animate {
        return Animate(duration: duration) { [weak self] in
            self?.scale(x: x, y: y)
        }
    }
    
    public func corner(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    public func corner(duration: TimeInterval, radius: CGFloat) -> Animate {
        return Animate(duration: duration) { [weak self] in
            self?.corner(radius: radius)
        }
    }
    
    public func color(_ color: UIColor) {
        backgroundColor = color
    }
    
    public func color(duration: TimeInterval, value: UIColor) -> Animate {
        return Animate(duration: duration) { [weak self] in
            self?.color(value)
        }
    }
}
