![KOLocalizedString: Helper for work and change language your application in Swift](/kolocalizedString.png)




[![Build Status](https://travis-ci.org/SethSky/KOLocalizedString.svg?branch=master)](https://travis-ci.org/SethSky/KOLocalizedString)[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/KOLocalizedString.svg)](https://img.shields.io/cocoapods/v/KOLocalizedString.svg)[![Platform](https://img.shields.io/cocoapods/p/KOLocalizedString.svg?style=flat)](https://img.shields.io/cocoapods/p/KOLocalizedString.svg?style=flat)

KOLocalizedString is an Localization library written in Swift.

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](Documentation/Usage.md)
- **Get started -** [Get started](Documentation/GetStarted.md)
- **Custom configuration -** [Custom configuration](Documentation/CustomConfiguration.md),
- **Network  configuration -** [Downloading Data to a File](Documentation/NetworkCustomConfiguration.md)
- **Localized string -** [Localized string](Documentation/LocalizedString.md)
- **Update language from server -** [Update language from server](Documentation/UpdateLanguageFromServer.md)
- [License](#license)

## Features

- [x] Usage .plist / .strings files
- [x] Update files from server
- [x] Update localization without rebooting application

## Requirements

- iOS 9.3+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.3+
- Swift 3.1+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build KOLocalizedString 0.0.1+.

To integrate KOLocalizedString into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'KOLocalizedString', '~> 0.0.4'
end
```

Then, run the following command:

```bash
$ pod install
```
## License

KOLocalizedString is released under the MIT license. [See LICENSE](LICENSE) for details.
