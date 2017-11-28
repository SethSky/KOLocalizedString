## Usage

### Get Localization string

```swift
import KOLocalizedString

KOLocalizedString("Key")
```
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
