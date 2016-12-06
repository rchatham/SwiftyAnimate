//
//  ViewController.swift
//  SwiftyAnimateDemo
//
//  Created by Reid Chatham on 12/4/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//

import UIKit
import SwiftyAnimate

class ViewController: UIViewController {
    
    struct Constants {
        static let defaultAnimationTime = 0.5
    }
    
    lazy var centerView: UIView = {
        let view = UIView(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: 200.0,
                height: 200.0
            )
        )
        view.center = self.view.center
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(centerView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let time = Constants.defaultAnimationTime
        
        // This!
        Animate(duration: time) { [unowned self] in
            // animation
            self.animationFunction()
        }.do { [unowned self] in
            // non-animation function
            self.nonAnimationFunction()
        }.then(duration: time) { [unowned self] in
            // animation
            self.animationFunction()
        }.wait { [unowned self] resume in
            // function that takes time
            self.functionThatTakesTime {
                resume()
            }
        }.then(duration: time) { [unowned self] in
            // animation
            self.animationFunction()
        }.then(duration: time) { [unowned self] in
            // animation
            self.animationFunction()
        }.perform { [unowned self] in
            
            self.pyramidOfDoom()
        }
        
    }
    
    func pyramidOfDoom() {
        
        let time = Constants.defaultAnimationTime
        
        // Not this!
        UIView.animate(withDuration: time, animations: { [unowned self] in
            // animation
            self.animationFunction()
        }) {  [unowned self] success in
            // non-animation function
            self.nonAnimationFunction()
            UIView.animate(withDuration: time, animations: {
                // animation
                self.animationFunction()
            }) { success in
                // function that takes time
                self.functionThatTakesTime {
                    UIView.animate(withDuration: time, animations: {
                        // animation
                        self.animationFunction()
                    }) { success in
                        UIView.animate(withDuration: time, animations: {
                            // animation
                            self.animationFunction()
                        })
                    }
                }
            }
        }
    }
    
    func animationFunction() {
        var newFrame = centerView.frame
        newFrame.size.width += .random(max: 50) - 25.0
        newFrame.size.height += .random(max: 50) - 25.0
        centerView.frame = newFrame
        centerView.center = view.center
    }
    
    func nonAnimationFunction() {
        if centerView.backgroundColor == .red {
            centerView.backgroundColor = .blue
        } else {
            centerView.backgroundColor = .red
        }
    }
    
    func functionThatTakesTime(_ callback: @escaping ()->Void) {
        let label = UILabel()
        label.text = "3"
        label.textColor = .black
        label.font = label.font.withSize(48)
        label.sizeToFit()
        label.center = centerView.center
        view.addSubview(label)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            label.text = "2"
            label.sizeToFit()
        }
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            label.text = "1"
            label.sizeToFit()
        }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            label.removeFromSuperview()
            callback()
        }
    }
    

}

extension CGFloat {
    /// - Returns: A random number below the max.
    static func random(max: UInt32) -> CGFloat {
        return CGFloat(arc4random_uniform(max))
    }
}

