Monet
=================================

[![Swift Version](https://img.shields.io/badge/swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Build Status](https://travis-ci.org/Digipolitan/dependency-injector.svg?branch=master)](https://travis-ci.org/Digipolitan/monet)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Monet.svg)](https://img.shields.io/cocoapods/v/Monet.svg)
[![Carthage Compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/Monet.svg?style=flat)](http://cocoadocs.org/docsets/Monet)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

Theme manager, to simplify applications appearences.

## Installation

### CocoaPods

To install Monet with CocoaPods, add the following lines to your `Podfile`.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'Monet'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Monet into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github 'Digipolitan/monet' ~> 2.0
```

Run `carthage update` to build the framework and drag the built `Monet.framework` into your Xcode project.

## The Basics

You need to **create** your theme template in **json**.<br>
On this example we create **default.json** which correspond to the default template of the app.

```json
{
    "identifier": "com.digipolitan.theme.default",
    "@colors": {
        "primary": "#FF877F"
    },
    "@fonts": {
        "regular-body": {
            "name": "Optima-Regular",
            "size": 48
        },
        "bold-action": {
            "name": "Optima-Bold",
            "size": 15
        }
    },
    "appearances": {
        "views": {
            "scene" : {
                "backgroundColor": "#123456"
            }
        },
        "texts": {
            "body": {
                "backgroundColor": "@colors/primary",
                "foregroundColor": "#323233",
                "font": "@fonts/regular-body"
            },
            "action": {
                "backgroundColor": "@colors/primary",
                "foregroundColor": "#FFFFFF",
                "font": "@fonts/bold-action"
            }
        }
    }
}
```
Then you can set your default theme like following

```swift
Monet.shared.theme = try? Theme.from(jsonFile: "default")
```

Then you can just set all the appearence of your app like following

```swift
self.label.setAppearance(theme.appearances.texts["body"])
self.view.setAppearance(theme.appearances.views["scene"])
```

Now it's possible to setup appearance in the InterfaceBuilder with the dynamic key `appearanceIdentifier` for each UIView subclasses

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

Monet is licensed under the [BSD 3-Clause license](LICENSE).
