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
        
//        heartView.goCrazy().perform()

        switch liked {
        case true:
            heartView.bounce().perform()
        default:
            heartView.tilt(angle: -0.33).perform()
        }
    }
    
    
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Animate()
            .then(animation: heartView.tilt(angle: -30))
            .do { [unowned self] in
                self.liked = !self.liked
            }
            .then(animation: heartView.bounce())
            .do { [unowned self] in
                self.liked = !self.liked
            }
            .then(animation: heartView.tilt(angle: -30))
            .perform { [unowned self] in
                self.heartView.isUserInteractionEnabled = true
            }
    }
    
}

/* 
 Writing custom animations is EASY!!!!!
 */

protocol Bounceable {
    func bounce() -> Animate
}

protocol Tiltable {
    func tilt(angle: CGFloat) -> Animate
}

extension UIView: Bounceable {
    func bounce() -> Animate {
        return Animate()
            .then(animation: scale(duration: 0.3, x: 1.3, y: 1.3))
            .then(animation: scale(duration: 0.3, x: 0.8, y: 0.8))
            .then(animation: scale(duration: 0.3, x: 1.1, y: 1.1))
            .then(animation: scale(duration: 0.3, x: 1.0, y: 1.0))
    }
}

extension UIView: Tiltable {
    func tilt(angle: CGFloat) -> Animate {
        return Animate()
            .then(animation: rotate(duration: 0.3, angle: angle))
            .wait(timeout: 0.5)
            .then(animation: rotate(duration: 0.3, angle: 0))
    }
}

/*
 Combine animations together!
 */

protocol GoCrazy {
    func goCrazy() -> Animate
}

extension UIView: GoCrazy {
    func goCrazy() -> Animate {
        return Animate()
            .then(animation: transform(duration: 0.3, transforms: [
                .rotate(angle: 180),
                .scale(x: 1.5, y: 1.5),
                .move(x: -10, y: -10),
            ]))
            .wait(timeout: 0.3)
            .then(animation: transform(duration: 0.3, transforms: [
                .move(x: 10, y: 10),
                .scale(x: 1.0, y: 1.0),
                .rotate(angle: 0),
            ]))
    }
}
