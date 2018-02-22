## Custom configuration

### Create configuration

To create custom configuration use KOConfigurationProtocol with  KOConfigurationBuilder
and add created configuration to core.

Example:

Create configuration builder
```swift
let configurationBuilder = KOConfigurationBuilder()
```
set 'http://yourdomain.com/api' value to URL
```swift
configurationBuilder.setUrl(string: "http://yourdomain.com/api")
```
Created configuration
```swift
let configuration = configurationBuilder.create()
```
Add created configuration to core
```swift
KOLocalizedCore.main.configureWith(configuration)
```
### Configuration builder
##### Available set

Set bundle | only if need used self bundle
```swift
func setBundle(bundle: Bundle?)
```
Set type file, default 'plist'
```swift
func setTypeFile(string: String)
```
Set dictionary ```swift Dictionary<String,Any>```, but if you set this property dictionary have to will be  ```swift Dictionary<String,String>```
```swift
func setDictionary(dictionary: Dictionary<String,Any>?)
```

 func isEnabelDebug(debug:Bool)




configurationBuilder.isEnabelDebug(debug: true)                         // Default 'false'
//        configurationBuilder.isUpdateOutside(update: true)                      // Default 'false'
configurationBuilder.setUrl(string: "http://test.khimich.com.ua/api")   // Default  ""
// configurationBuilder.setFileName(string: "LocalizableNestedDic")        // Default "Localizable"
// configurationBuilder.setDefaultLanguageKey(string: "uk")                // Default  nil




var bundle              : Bundle?
var typeFile            : String
var dictionary          : Dictionary<String, Any>?
var defaultLanguageKey  : String?
var fileName            : String
var url                 : URL?
var isUpdateOutside     : Bool
var isEnabelDebug       : Bool





