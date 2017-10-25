Monet
=================================

[![Build Status](https://travis-ci.org/Digipolitan/dependency-injector.svg?branch=master)](https://travis-ci.org/Digipolitan/monet)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Monet.svg)](https://img.shields.io/cocoapods/v/Monet.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/Monet.svg?style=flat)](http://cocoadocs.org/docsets/Monet)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

Theme manager, to simplify applications appearences.

## Installation

### CocoaPods

To install Monet with CocoaPods, add the following lines to your `Podfile`.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0' # or platform :osx, '10.10' if your target is OS X.
use_frameworks!

pod 'Monet'
```

## The Basics

First you must add into your **Info.plist** the key **Themes** of type **array** with your themes names.
```xml
<key>Themes</key>
<array>
	<string>custom</string>
	<string>other</string>
	<string>default</string>
</array>
```

After that you need to **create** youre theme template in **json**.<br>
On this example we create **default.json** which correspond to the default template of the app.

```json
{
    "identifier": "com.digipolitan.theme.default",
    "body": {
        "backgroundColor": "#00000000",
        "foregroundColor": "#000000",
        "font": {
            "name": "Optima-Bold",
            "size": 48
        }
    },
    "h1": {
        "backgroundColor": "#00000000",
        "foregroundColor": "#363636",
        "font": {
            "name": "Optima-Regular",
            "size": 14
        }
    },
    "placeholder": {
        "backgroundColor": "#00000000",
        "foregroundColor": "#ABABAB",
        "font": {
            "name": "Optima-Regular",
            "size": 15
        }
    },
    "input": {
        "backgroundColor": "#00000000",
        "foregroundColor": "#000000",
        "font": {
            "name": "Optima-Regular",
            "size": 15
        }
    },
    "action": {
        "backgroundColor": "#FFFFFF",
        "foregroundColor": "#FFFFFF",
        "font": {
            "name": "Optima-Bold",
            "size": 15
        }
    }
}
```
Then you can set your default theme like following

```swift
let manager = ThemeManager.shared
guard let defaultTheme = manager.themes.first(where: { $0.identifier == "com.digipolitan.theme.default" }) else {
	return
}
manager.current = defaultTheme
```

Then you can just set all the appearence of your app like following

```swift
self.label.setAppearance(theme.body)
self.view.setAppearance(theme.action)
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

Monet is licensed under the [BSD 3-Clause license](LICENSE).
