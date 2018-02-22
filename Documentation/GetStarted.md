## Get started

 ### Installation
 
 [CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
 
 ```bash
 $ gem install cocoapods
 ```
 
 > CocoaPods 1.1+ is required to build KOLocalizedString 1.0.0+.
 
 To integrate KOLocalizedString into your Xcode project using CocoaPods, specify it in your `Podfile`:
 
 ```ruby
 source 'https://github.com/CocoaPods/Specs.git'
 platform :ios, '10.0'
 use_frameworks!
 
 target '<Your Target Name>' do
 pod 'KOLocalizedString', '~> 1.0.0'
 end
 ```
 
 Then, run the following command:
 
 ```bash
 $ pod install
 ```
 
### Setup default configuration

```swift
import KOLocalizedString
```

Add to AppDelegate in method

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
```
this  code

```swift
 KOLocalizedCore.main.configure()
 ```
 ### Create values file
 
 Add to your project  '.plist'  file with name  'Localizable' example:
 
 <div align="left">
 <img src="/Documentation/Assets/Localizable_plist.png" width="264" height="61">
 </div>
 
 or  'Localizable.strings' example:
 
 <div align="left">
 <img src="/Documentation/Assets/Localizable_plist.png" width="264" height="61">
 </div>
 
### Add key and values to file
If you using Localizable.plist example:

<div align="left">
<img src="/Documentation/Assets/key_value_plist.png">
</div>

or If you using Localizable.strings example:

<div align="left">
<img src="/Documentation/Assets/key_value_strings.png">
</div>


 ### Get Localization string
 
 use   ```swift func KOLocalizedString(_ key: String) -> String ```  method to get localized string.
 
 ```swift
 self.title = KOLocalizedString("Key")
 ```
 
  ### More info
  - **Custom configuration -** [Custom configuration](/Documentation/CustomConfiguration.md)
  - **Network  configuration -** [Downloading Data to a File](/Documentation/NetworkCustomConfiguration.md)
  - **Localized string -** [Localized string](/Documentation/LocalizedString.md)
  - **Update language from server -** [Update language from server](/Documentation/UpdateLanguageFromServer.md)
