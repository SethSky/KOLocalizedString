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
#### Available set: KOConfigurationBuilder

Set bundle. Only if need used self bundle.  - optional
```swift
func setBundle(bundle: Bundle?)
```
Set type file, default 'plist'
```swift
func setTypeFile(string: String)
```
Set dictionary ```Dictionary<String,Any>```, but if you set this property dictionary have to will be  ```Dictionary<String,String>``` - optional
```swift
func setDictionary(dictionary: Dictionary<String,Any>?)
```

Set default language key, example "en".  Set up in case if the application is needed to launch with default language
```swift
public func setDefaultLanguageKey(string: String)
```

Set file name. Default  ```Localizable```
 ```swift
func setFileName(string: String)
```

Set URL for destination resource for get response about language files information
```swift
func setUrl(string: String)
```

Set is update outside. Default  ```false```(not update)
```swift
func isUpdateOutside(update:Bool)
```
Set is enable debug. Default ```false``` (not show debug in console)
```swift
public func isEnableDebug(debug:Bool)
```
  ### More info 
  - [Get started](/Documentation/GetStarted.md)
  - **Custom configuration -** [Network Custom configuration](/Documentation/NetworkCustomConfiguration.md)
  - [Updating files from server](/Documentation/UpdatingFromServer.md)
  - [Localized string](/Documentation/LocalizedString.md)
  - [Update language from server](/Documentation/UpdateLanguageFromServer.md)
