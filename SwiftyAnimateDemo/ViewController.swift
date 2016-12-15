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
    
    var liked: Bool = false {
        didSet {
            guard oldValue != liked else { return }
            switch liked {
            case true:
                heartView.image = #imageLiteral(resourceName: "RedHeart")
            case false:
                heartView.image = #imageLiteral(resourceName: "Heart")
            }
        }
    }
    
    @IBOutlet weak var heartView: UIImageView! {
        didSet {
            heartView.image = #imageLiteral(resourceName: "Heart")
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedHeart(_:)))
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            heartView.addGestureRecognizer(tap)
        }
    }
    
    func tappedHeart(_ sender: UITapGestureRecognizer) {
        liked = !liked
        
        switch liked {
        case true:
            Animate().bounce(view: heartView).perform()
        default:
            Animate().tilt(view: heartView, rotationAngle: -0.33).perform()
        }
    }
    
    
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        Animate()
//            .tilt(view: heartView, rotationAngle: -0.33)
//            .do { [unowned self] in
//                self.liked = !self.liked
//            }
//            .bounce(view: heartView)
//            .do { [unowned self] in
//                self.liked = !self.liked
//            }
//            .tilt(view: heartView, rotationAngle: -0.33)
//            .perform { [unowned self] in
//                self.heartView.isUserInteractionEnabled = true
//            }
        
        Animate()
            .then(animation: heartView.tilt(rotationAngle: -0.33))
            .do { [unowned self] in
                self.liked = !self.liked
            }
            .then(animation: heartView.bounce())
            .do { [unowned self] in
                self.liked = !self.liked
            }
            .then(animation: heartView.tilt(rotationAngle: -0.33))
            .perform { [unowned self] in
                self.heartView.isUserInteractionEnabled = true
            }
    }
    
}

/* 
 Writing custom animations is EASY!!!!! 
 
 There are two ways to write animations as extensions to help keep your code clean and readable using this framework.
 */


// Protocols and extenstions on your views that are performing them.

protocol Bounceable {
    func bounce() -> Animate
}

protocol Tiltable {
    func tilt(rotationAngle: CGFloat) -> Animate
}

extension UIView: Bounceable {
    func bounce() -> Animate {
        return Animate(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }.then(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }.then(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }.then(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}

extension UIView: Tiltable {
    func tilt(rotationAngle: CGFloat) -> Animate {
        return Animate(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(rotationAngle: rotationAngle)
        }.wait(timeout: 0.5) { _ in
        }.then(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(rotationAngle: 0.0)
        }
    }
}

// Protocols and extenstions to Animate take a view to perform them on.

extension Animate {
    
    func bounce(view: UIView) -> Animate {
        return then(duration: 0.3) {
            view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }.then(duration: 0.3) {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }.then(duration: 0.3) {
            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }.then(duration: 0.3) {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func tilt(view: UIView, rotationAngle: CGFloat) -> Animate {
        return then(duration: 0.3) {
            view.transform = CGAffineTransform(rotationAngle: rotationAngle)
        }.wait(timeout: 0.5) { _ in
        }.then(duration: 0.3) {
            view.transform = CGAffineTransform(rotationAngle: 0.0)
        }
    }
}
