# SwiftyAnimate

### Syntax sugar for animations in Swift. Escape the Pyramid of DOOM!!! [Blog](https://goo.gl/EHT54H)

![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat)
[![Language: Swift 3](https://img.shields.io/badge/language-swift3-f48041.svg?style=flat)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://cocoapod-badges.herokuapp.com/v/SwiftyAnimate/badge.png)](https://cocoapods.org/pods/SwiftyAnimate)
[![SPM compatible](https://img.shields.io/badge/spm-supported-orange.svg)](https://swift.org/package-manager/)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/SwiftyAnimate.svg)](http://cocoadocs.org/docsets/SwiftyAnimate)
[![Codecov](https://img.shields.io/codecov/c/github/rchatham/SwiftyAnimate.svg)]()
[![Travis](https://img.shields.io/travis/rchatham/SwiftyAnimate.svg)](https://travis-ci.org/rchatham/SwiftyAnimate)
![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)

<img src="http://reidchatham.com/src/SwiftyAnimate.gif" width="200">


## Installation

#### Cocoapods

The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

```ruby
pod 'SwiftyAnimate', '~> 1.0.1'
```

#### Carthage

```ruby
github "rchatham/SwiftyAnimate"
```

#### Swift Package Manager

Add the following line 

```swift
.Package(url: "https://github.com/rchatham/SwiftyAnimate.git", majorVersion: 0) 
```

to your Package.swift file as illustrated below. 

```swift
import PackageDescription

let package = Package(
    name: "YourAppName",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/rchatham/SwiftyAnimate.git", majorVersion: 0),
        ]
)
```


## This!

```swift
// Escape the Pyramid of DOOM!
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
}.perform()
```

## Not this!

```swift
// Or... the Pyramid of DOOM!!!!
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
```

## Usage

This library can be used to design simple to complex animations and keeps animation code readable and maintainable.

### Composing Animations

Compose animations and insert logic to the flow of animatinos using the `then`, `do`, and `wait` functions.

#### Then blocks

Add animations to the current instance using one of the implementations for this function. There are implemetations for both standard nd spring animations as well as chaining animation instances.

```swift
Animate(duration: 1.0) {
        // animation code goes here
    }
    .then(duration: 0.5) {
        // more animation code
    }
    .perform()
```

#### Do blocks

Add code that you don't intend on animating but would like to perform between animations here. Any code you put here will NOT be animated.

```swift
Animate(duration: 1.0) {
        // animation code goes here
    }
    .do {
        // logic you don't want to animate
    }
    .then(duration: 0.5) {
        // more animation code
    }
    .perform()
```

#### Wait blocks

Add code that you may want to pause an ongoing chain of animations for. Any code you put here will NOT be animated. You can pass in a timeout if you want to wait for a specific amount of time or if you don't want to wait longer to execute the code in the wait block. 

```swift
Animate(duration: 1.0) {
        // animation code goes here
    }
    .wait(timeout: 5.0) { resume in
        // logic you don't want to pause an animation to complete
        resume()
    }
    .then(duration: 0.5) {
        // more animation code
    }
    .perform()
```

### Performing Animations

There are two ways to perform animations `finish` and `perform`. * Important: You must either call one of these two functions or `decay` on an animation instance or this will result in a memory leak! *

#### Perform

This one is easy. Call this on an animation instance to perform it. Perform takes an optional closure which gets excecuted on completing the last animation block.

```swift
let animation = Animate(duration: 1.0) {
    // animations
}

animation.perform()
```

#### Finish

If you don't need to pass in a completion closure try calling finish on your animation instance. The animation passed in is enqueue'd and then perform is called on the instance. Finish has all of the same variations as the then function.

```swift
Animate(duration: 1.0) {
        // animations
    }
    .finish(duration: 1.0) {
        // animations
    }
```

#### Decay

If you would like to deallocate an animation instance without performing it call decay on it.

```swift
let animation = Animate(duration: 1.0) {
    // animations
}

animation.decay()
```

### Best Practices

The best way to take advantage of this library is define extensions for the views that you would like to animate. This compartmentailizes your code and keep all the animation logic tucked up within the view and out of your view controllers.

```swift
extension AnimatingView {
    func bounceAnimation() -> Animate {
        return Animate(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
        .then(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        .then(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        .then(duration: 0.3) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
```

Then when you go to perform an animation you just have to call `perform()` on the returned animation.

```swift
let animatingView = AnimatingView()

animatingView.bounceAnimation().perform()
```

And string them together with other animations for building up complex animation logic easily.

```swift
Animate()
    .then(animation: animatingView.bounceAnimation())
    .then(animation: animatingView.tiltAnimation())
    .then(animation: animatingView.bounceAnimation())
    .perform()
```

### Contributing

I would love to see your ideas for improving this library! The best way to contribute is by submitting a pull request. I'll do my best to respond to your patch as soon as possible. You can also submit a [new GitHub issue](https://github.com/rchatham/SwiftyAnimate/issues/new) if you find bugs or have questions. 🙏

Please make sure to follow our general coding style and add test coverage for new features!
