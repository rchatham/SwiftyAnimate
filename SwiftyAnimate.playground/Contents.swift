//: Playground - noun: a place where people can play

import UIKit
import SwiftyAnimate

var str = "Hello, playground"


class View: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let time = 0.5
        
        // This!
        Animate(duration: time) {
            // animation
        }.do { [unowned self] in
            // non-animation function
            self.function {}
        }.then(duration: time) {
            // animation
        }.wait { [unowned self] resume in
            // function that takes time
            self.function {
                resume()
            }
        }.then(duration: time) {
            // animation
        }.then(duration: time) {
            // animation
        }.perform()
        
        
        // Not this!
        UIView.animate(withDuration: time, animations: { 
            // animation
        }) { success in
            // non-animation function
            self.function {}
            UIView.animate(withDuration: time, animations: {
                // animation
            }) { [unowned self]  success in
                // function that takes time
                self.function {
                    UIView.animate(withDuration: time, animations: {
                        // animation
                    }) { success in
                        UIView.animate(withDuration: time, animations: {
                            // animation
                        })
                    }
                }
            }
        }
    }
    
    func function(callback: (Void)->Void) {
        callback()
    }
}