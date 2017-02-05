<img src="http://reidchatham.com/src/SwiftyAnimate.png">

### Composable animations in Swift. [Blog](https://goo.gl/EHT54H)

![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat)
[![Language: Swift 3](https://img.shields.io/badge/language-swift3-f48041.svg?style=flat)](https://developer.apple.com/swift)
![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)

[![Cocoapods compatible](https://cocoapod-badges.herokuapp.com/v/SwiftyAnimate/badge.png)](https://cocoapods.org/pods/SwiftyAnimate)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM compatible](https://img.shields.io/badge/spm-supported-orange.svg)](https://swift.org/package-manager/)

[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/SwiftyAnimate.svg)](http://cocoadocs.org/docsets/SwiftyAnimate)
[![Codecov](https://img.shields.io/codecov/c/github/rchatham/SwiftyAnimate.svg)](https://codecov.io/gh/rchatham/SwiftyAnimate)
[![Travis](https://img.shields.io/travis/rchatham/SwiftyAnimate.svg)](https://travis-ci.org/rchatham/SwiftyAnimate)
[![Code Climate](https://codeclimate.com/github/rchatham/SwiftyAnimate/badges/gpa.svg)](https://codeclimate.com/github/rchatham/SwiftyAnimate)

<img src="http://reidchatham.com/src/SwiftyAnimate.gif" width="200">


## Installation

#### Cocoapods

The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

```ruby
pod 'SwiftyAnimate', '~> 1.3.0'
```

#### Carthage

```ruby
github "rchatham/SwiftyAnimate"
```

#### Swift Package Manager

Add the following line to your Package.swift file. 

```swift
.Package(url: "https://github.com/rchatham/SwiftyAnimate.git", majorVersion: 0) 
```

## Usage

This library can be used to design composable animations while keeping animation code readable and maintainable.

### Composing Animations

Compose animations and insert logic inbetween them using the `then`, `do`, and `wait` functions.

#### Then blocks

Add animations to the current instance using one of the implementations for this function. There are implemetations for spring and keyframe animations as well as chaining `Animate` objects together.

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
        // logic you want to pause an animation to complete
        resume()
    }
    .then(duration: 0.5) {
        // more animation code
    }
    .perform()
```

### Performing Animations

There are two ways to perform animations `finish` and `perform`. **Important: You must either call one of these two functions or** `decay` **on an animation instance or this will result in a memory leak!**

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

### UIView Extensions

A number of animatable properties have extensions defined to make implementing them with this library even easier. Please check the docs!

### Best Practices

The best way to take advantage of this library is define extensions for the views that you would like to animate. This compartmentailizes your code and keep all the animation logic tucked up within the view and out of your view controllers.

```swift
extension AnimatingView {
    func bounceAnimation() -> Animate {
        return Animate()
            .then(animation: scale(duration: 0.3, x: 1.3, y: 1.3))
            .then(animation: scale(duration: 0.3, x: 0.8, y: 0.8))
            .then(animation: scale(duration: 0.3, x: 1.1, y: 1.1))
            .then(animation: scale(duration: 0.3, x: 1.0, y: 1.0))
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
