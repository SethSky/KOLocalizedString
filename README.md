![KOLocalizedString: Localization library written in Swift](https:// /KOLocalizedString/master/KOLocalizedString.png)

[![Build Status](https://travis-ci.org/SethSky/KOLocalizedString.svg?branch=master)](https://travis-ci.org/SethSky/KOLocalizedString)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/KOLocalizedString.svg)](https://img.shields.io/cocoapods/v/KOLocalizedString.svg)   
[![Platform](https://img.shields.io/cocoapods/p/KOLocalizedString.svg?style=flat)](https://img.shields.io/cocoapods/p/KOLocalizedString.svg?style=flat)

KOLocalizedString is an Localization library written in Swift.

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](Documentation/Usage.md)
- [License](#license)

## Features

- [x] Usage .plist / .strings files
- [x] Update files from server
- [x] Update localization without rebooting application

## Requirements

- iOS 9.0+
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
    pod 'KOLocalizedString', '~> 0.0.2'
end
```

Then, run the following command:

```bash
$ pod install
```
## License

KOLocalizedString is released under the MIT license. [See LICENSE](https://github.com/SethSky/KOLocalizedString/blob/master/LICENSE) for details.