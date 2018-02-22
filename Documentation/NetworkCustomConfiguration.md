
### How use update files from server

If you will need update Localized files from server: add code to AppDelegate where you specify the URL API. this url  will be open to KOLocalizedNetwork.

```swift
import KOLocalizedString

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
KOLocalizedCore.main.url = "http://example.com/api"
return true
}
}
```
After added URL to Core, manager network (KOLocalizedNetwork) create .GET request to URL with language key, bundle id and version. After create full URL will send request.

#### Example Request
http://khimich.com.ua/api/?key=en&ver=1.0&bundle=com.domine.Example
Request parameters:
key = en
ver = 1.0
bundle = com.domine.Example

Response must contain array objects for parsing JSON.
Object must contain key "filename" - name file, "url" - url to file, "latest_update" - the value of which will be checked, updated file or not.

#### Example Response
```JSON
{
"array":[
{
"filename":"Localizable.plist",
"url":"http://example.com/localizable/com.khymych.KOLocalized/1.0/en/Localizable.plist",
"latest_update":"2017-Nov-24'EET'16:11:45"
},
{
"filename":"Localizable.strings",
"url":"http://example.com/localizable/com.khymych.KOLocalized/1.0/en/Localizable.strings",
"latest_update":"2017-Nov-23'EET'16:11:45"
}
]
}
```

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
