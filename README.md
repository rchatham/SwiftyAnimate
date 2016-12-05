# SwiftyAnimate

### Syntax sugar for animations in Swift. Escape the Pyramid of DOOM!!!

![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat)
[![Language: Swift 3](https://img.shields.io/badge/language-swift3-f48041.svg?style=flat)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://cocoapod-badges.herokuapp.com/v/SwiftyAnimate/badge.png)](https://cocoapods.org/pods/SwiftyAnimate)
[![SPM compatible](https://img.shields.io/badge/spm-supported-orange.svg)](https://swift.org/package-manager/)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/SwiftyAnimate.svg)](http://cocoadocs.org/docsets/SwiftyAnimate)
[![Codecov](https://img.shields.io/codecov/c/github/rchatham/SwiftyAnimate.svg)]()
[![Travis](https://img.shields.io/travis/rchatham/SwiftyAnimate.svg)](https://travis-ci.org/rchatham/SwiftyAnimate)
![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)


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
}.perform { [unowned self] in
    
    self.pyramidOfDoom()
}
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


## Installation

#### Cocoapods

The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

```ruby
pod 'SwiftyAnimate', '~> 0.0.2'
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

