//: Playground - noun: a place where people can play

import UIKit
import SwiftyAnimate

var str = "Hello, playground"


let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))

print(view.transform)

print(CGAffineTransform(scaleX: 1.0, y: 1.0))

print(CGAffineTransform(rotationAngle: 0.0))

print(CGAffineTransform(translationX: 10, y: 10))

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let time = 0.5
        
        // This!
        Animate(duration: time) {
            // animation
            self.animationFunction()
        }.do { [unowned self] in
            // non-animation function
            self.nonAnimationFunction()
        }.then(duration: time) {
            // animation
            self.animationFunction()
        }.wait { [unowned self] resume in
            // function that takes time
            self.functionThatTakesTime {
                resume()
            }
        }.then(duration: time) {
            // animation
            self.animationFunction()
        }.then(duration: time) {
            // animation
            self.animationFunction()
        }.perform()
        
        
        // Not this!
        UIView.animate(withDuration: time, animations: {
            // animation
            self.animationFunction()
        }) { success in
            // non-animation function
            self.nonAnimationFunction()
            UIView.animate(withDuration: time, animations: {
                // animation
                self.animationFunction()
            }) { [unowned self]  success in
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
    
    func nonAnimationFunction() {
        
    }
    
    func functionThatTakesTime(callback: @escaping ()->Void) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            callback()
        }
    }
    
    func animationFunction() {
        view.subviews.forEach { $0.removeFromSuperview() }
        
        let redView: UIView = {
            $0.backgroundColor = .red
            return $0
        } (UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        
        view.addSubview(redView)
        redView.center = view.center
        
        redView.frame.origin.y = redView.frame.origin.y + 100
    }
}



