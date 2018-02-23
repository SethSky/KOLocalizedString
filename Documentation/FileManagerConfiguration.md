## File manager configuration

### Create configuration

To create  file manager custom configuration use KOFileManagerConfigurationProtocol with  KOFileManagerConfigurationBuilder
and add created configuration to network configuration.

Example:

Create configuration builder
```swift
let fileManagerConfigurationBuilder = KOFileManagerConfigurationBuilder()
```
Created configuration
```swift
let fileManagerConfiguration = fileManagerConfigurationBuilder.create()!
```
Set configuration to [KONetworkConfigurationBuilder ](/Documentation/NetworkCustomConfiguration.md)
```swift
networkConfigurationBuilder.setFileManagerConfiguration(configuration:fileManagerConfiguration)
```
### File manager Configuration builder
#### Available set: KOFileManagerConfigurationBuilder

Set file manager. If not set default  ```FileManager.default```
```swift
 func setManager(manager: FileManager)
```
Set languages directory name. If not set default  ```Languages```
```swift
func setDirectoryName(string: String)
```
Set search path directory. If not set default  ```.applicationSupportDirectory```
```swift
func setSearchPathDirectory(directory: FileManager.SearchPathDirectory)
```
Set search path domain mask. If not set default  ```.userDomainMask```
```swift
func setSearchPathDomainMask(domainMask: FileManager.SearchPathDomainMask)
```
Set is enable debug. If not set default  ```false```
```swift
func setIsEnableDebug(enable: Bool)
```

Create KOFileManagerConfiguration
```swift
func create() -> KOFileManagerConfigurationProtocol?
```

### More info 
- [Get started](/Documentation/GetStarted.md)
- **Custom configuration -** [Core custom configuration](/Documentation/CustomConfiguration.md),  [Network Custom configuration](/Documentation/NetworkCustomConfiguration.md)
- [Updating files from server](/Documentation/UpdatingFromServer.md)
- [Localized string](/Documentation/LocalizedString.md)
- [Update language from server](/Documentation/UpdateLanguageFromServer.md)
