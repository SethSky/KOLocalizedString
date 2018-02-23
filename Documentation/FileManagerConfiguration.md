## Network configuration

### Create configuration

To create  network custom configuration use KONetworkConfigurationProtocol with  KONetworkConfigurationBuilder
and add created configuration to core.

Example:

Create configuration builder
```swift
let networkConfigurationBuilder = KONetworkConfigurationBuilder()
```
set 'http://yourdomain.com/api' value to URL
```swift
configurationBuilder.setUrl(string: "http://yourdomain.com/api")
```
Created configuration
```swift
let networkConfiguration = networkConfigurationBuilder.create()
```
Add created configuration to core
```swift
KOLocalizedCore.main.networkConfigure(networkConfiguration)
```
### Network Configuration builder
#### Available set: KONetworkConfigurationBuilder

Set session. If not set default  ```URLSession(configuration: URLSessionConfiguration.default)```
```swift
 func setSession(session: URLSession)
```
Set fileNameKey. If not set default  ```filename```
```swift
func setFileNameKey(string: String)
```
Set urlKey. If not set default  ```url```
```swift
func setUrlKey(string: String)
```
Set latestUpdateKey. If not set default  ```latest_update```
```swift
func setLatestUpdateKey(string: String)
```
Set rootPointKey optional. If not set default  ```array```
```swift
func setRootPointKey(string: String?)
```
Set request language key optional. If not set default  ```key```
```swift
func setRequestLangKey(string: String?)
```
Set request Bundle key optional. If not set default  ```bundle```
```swift
func setRequestBundlekey(string: String?)
```
Set request version build key optional. If not set default  ```ver```
```swift
func setRequestVersionkey(string: String?)
```
Set file manager configuration optional. If not set create default [File manager configuration](/Documentation/FileManagerConfiguration.md)
```swift
func setFileManagerConfiguration(configuration:KOFileManagerConfigurationProtocol)
```
Create KONetworkConfiguration
```swift
func create() -> KONetworkConfigurationProtocol
```

### More info 
- [Get started](/Documentation/GetStarted.md)
- **Custom configuration -** [Core custom configuration](/Documentation/CustomConfiguration.md),  [Network Custom configuration](/Documentation/NetworkCustomConfiguration.md)
- [Updating files from server](/Documentation/UpdatingFromServer.md)
- [Localized string](/Documentation/LocalizedString.md)
- [Update language from server](/Documentation/UpdateLanguageFromServer.md)
