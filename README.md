# Resizin

[![Version](https://img.shields.io/cocoapods/v/Resizin.svg?style=flat)](http://cocoapods.org/pods/Resizin)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Resizin.svg?style=flat)](http://cocoapods.org/pods/Resizin)
[![Platform](https://img.shields.io/cocoapods/p/Resizin.svg?style=flat)](http://cocoapods.org/pods/Resizin)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Resizin requires iOS 8 and later.

## Installation

Resizin is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Resizin"
```

Resizin is also available through [Carthage](https://github.com/Carthage/Carthage). To install it, simply add the following line to your Cartfile

```ruby
github "AckeeCZ/Resizin-iOS-SDK"
```

## Usage

At the beginning you need to set up the shared `ResizinManager` using your *project name* and *client key*. Typically you do this in your `AppDelegate`.

```swift
let projectName = "ackee" // put your project name here
let clientKey = "ackee_test_key" // put your client key here
ResizinManager.setupSharedManager(projectName: projectName, clientKey: clientKey)
```

When you have your shared manager set up you can then obtain direct url to you image.

```swift
let imageURL = ResizinManager.shared.url(for: "image_key")
```

This url just obtains url to the image "as is", if you want to apply any transformations you need to provide `ResizinSettings`.

You can request various transformations:
- size
- crop mode
- gravity
- filters
- quality
- rotation
- upscale flag
- background color
- alpha
- border

```swift
let size = ResizinSize(cgSize: CGSize(width: 100, height: 200), scale: Int(UIScreen.main.scale))
let settings = ResizinSettings(size: Constants.resizinSize, cropMode: .fill)
let imageURL = ResizinManager.shared.url(for: "image_key", settings: settings)
```

## Author

Ackee team

## License

Resizin is available under the MIT license. See the LICENSE file for more info.
