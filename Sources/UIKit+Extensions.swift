//
//  UIKit+Extensions.swift
//  SwiftyAnimate
//
//  Created by Reid Chatham on 12/23/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import Foundation

extension UIView {
    
    /**
     Perform multiple core graphics transformations on a view.
     
     - parameter transforms: Array of transformations to be performed on the view represented by `Transform` enum cases.
     */
    public func transformed(by transforms: [Transform]) {
        var transform: CGAffineTransform?
        for t in transforms {
            switch t {
            case .rotate(angle: let angle):
                let angle = angle * CGFloat(M_PI / 180)
                transform = transform?.rotated(by: angle) ?? CGAffineTransform(rotationAngle: angle)
            case .scale(x: let x, y: let y):
                transform = transform?.scaledBy(x: x, y: y) ?? CGAffineTransform(scaleX: x, y: y)
            case .move(x: let x, y: let y):
                transform = transform?.translatedBy(x: x, y: y) ?? CGAffineTransform(translationX: x, y: y)
            }
        }
        if let transform = transform {
            self.transform = transform
        }
    }
    
    /**
     Performs a translation core graphics transformation on a view.
     
     - parameter x: Value to shift in the x direction.
     - parameter y: Value to shift in the y direction.
     */
    public func move(x: CGFloat, y: CGFloat) {
        transformed(by: [.move(x: x, y: y)])
    }
    
    /**
     Performs a rotation core graphics transformation on a view.
     
     - parameter angle: Degrees to rotate the view.
     */
    public func rotate(angle: CGFloat) {
        transformed(by: [.rotate(angle: angle)])
    }
    
    /**
     Performs a scale core graphics transformation on a view.
     
     - parameter x: Value to scale in the x direction.
     - parameter y: Value to scale in the y direction.
     */
    public func scale(x: CGFloat, y: CGFloat) {
        transformed(by: [.scale(x: x, y: y)])
    }
    
    /**
     Sets the view's background color.
     
     - parameter color: Value for the new background color.
     */
    public func color(_ color: UIColor) {
        backgroundColor = color
    }
    
    /**
     Sets the corner radius on the view's CALayer.
     
     - parameter radius: Value for the new corner radius.
     */
    public func corner(radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
