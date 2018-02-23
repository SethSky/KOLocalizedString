## Localized string
### Global api

Returns a localized string, using the main bundle if one is not specified.
```swift
func KOLocalizedString(_ key: String, comment: String) -> String
```
 Returns a localized string
```swift
func KOLocalizedString(_ key: String) -> String
```
Current language key
```swift
func KOCurrentLanguageKey()->String
```
Set Language
```swift
func KOSetLanguage(_ key:String)
```
Get localized image with name and type file. if not found file return empty UIImage
```swift
func KOLocalizedImage(forResource:String,  ofType:String)->UIImage
```
Get localized image with name. If change language return new image after reload application. if not found file return empty UIImage
```swift
func KOLocalizedImage(named:String)->UIImage
```
Get path file. Return optional String
```swift
func KOLocalizedFilePath(forResource:String,  ofType:String)->String?
```
Get language keys array. Not returning "Base" language
```swift
func KOGetLanguageArray()->Array<String>{
```

### More info
- [Get started](/Documentation/GetStarted.md)
- **Custom configuration -** [Core custom configuration](/Documentation/CustomConfiguration.md),  [Network Custom configuration](/Documentation/NetworkCustomConfiguration.md),  [File manager configuration](/Documentation/FileManagerConfiguration.md)
- [Updating files from server](/Documentation/UpdatingFromServer.md)
- [Update language from server](/Documentation/UpdateLanguageFromServer.md)
