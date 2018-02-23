## Updating files from server

 ### Configuration
 
 To usege  updating files from server need create custom configuration and set 'URL'  and 'isUpdateOutside' it.
 ```swift
 let configurationBuilder = KOConfigurationBuilder()
 configurationBuilder.setUrl(string: "http://yourdomain.com/api")
 configurationBuilder.isUpdateOutside(update: true)
 let configuration = configurationBuilder.create()
 KOLocalizedCore.main.configureWith(configuration)
 ```
  Next step create default or custom network configuration.
  Example default
  ```swift
  KOLocalizedCore.main.networkConfigure(nil)
 ```
 Detail about custom network configuration - [Network  configuration](/Documentation/NetworkCustomConfiguration.md)
 
 ### How use update files from server
 After added  network configuration you can use update file from server.
 
 After launch application KOLocalizedCore creating mediator and send ```.GET``` request to said url in network configuration.
 ##### Example Request
 ```http://khimich.com.ua/api/?key=en&ver=1.0&bundle=com.domine.Example```
##### Request parameters:

```key``` = ```en``` - language key

 ```ver ```= ```1.0``` - varsion key
 
 ```bundle``` = ```com.domine.Example``` - bundle id key
 
  All keys can be configured in the [Network  configuration](/Documentation/NetworkCustomConfiguration.md)
  
 ##### Example Response
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
Response must contain array objects for parsing JSON with root point  ```array``` or said on network configuration.
 
##### Object must contain keys:

 ```filename``` - name file,
 
  ```url``` - url to file,
  
  ```latest_update ``` - the value of which will be checked, updated file or not. (method is equal)
  
All keys can be configured in the [Network  configuration](/Documentation/NetworkCustomConfiguration.md)

##### If exist correct files list in response:

Mediator create command to downloading this files and it saved to temporary directory .
After downloading full files list   ```languageKey.jroj ``` moved  to  ```Language ``` directory.
When new files to be moveded complete, mediator set self new 'bundle' and callback to core with new 'bundle'.
You can track the change with notification ```KODidUpdateBundle``` or callback ```KOLocalizedCore.main.completeUpdate```
You can also track errors  ```KOLocalizedCore.main.errorCallback ```.

  ### More info
  - [Get started](/Documentation/GetStarted.md)
  - **Custom configuration -** [Core custom configuration](/Documentation/CustomConfiguration.md),  [Network Custom configuration](/Documentation/NetworkCustomConfiguration.md),  [File manager configuration](/Documentation/FileManagerConfiguration.md)
  - [Localized string](/Documentation/LocalizedString.md)
  - [Update language from server](/Documentation/UpdateLanguageFromServer.md)
