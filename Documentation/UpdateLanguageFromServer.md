## Update language from server

### How use update language from server

First step its add url to configuration and set isUpdateOutside.  [more detail](/Documentation/CustomConfiguration.md)

Second step, add language file to server.

After launch application KOLocalizedCore creating mediator and send request to said url.

If exist correct files list in response, mediator create command to downloading this files and it saved to temporary directory .

After downloading full files list  'languageKey.jroj' moved  to 'Language' directory.

When new files to be moveded complete, mediator set self new 'bundle' and callback to core with new 'bundle'.

Whereupon if you using plist, language dictionary will be update. [more detail](/Documentation/UpdatingFromServer.md)

### You can use a simple web site with a file hosting service
#### Example server on PHP

 ```PHP
 <?php
    $key = $_GET['key'];
    $bundle = $_GET['bundle'];
    $ver = $_GET['ver'];
    header('Content-Type: application/json');
 
    $baseUrl =  '../localizable/';
if (validateKey($key) || validateKey($bundle) || validateKey($ver)) {
    if (validateKey($key)){
        echo json_encode(errorMessage('key'));
    }elseif (validateKey($bundle)) {
        echo json_encode(errorMessage('bundle'));
    }elseif (validateKey($ver)){
        echo json_encode(errorMessage('ver'));
    }
}else{
    echo str_replace('\\', '',json_encode(getFileArray($key, $bundle, $ver)));
}
 
function validateKey($value)
{
    return (is_null($value) || empty($value));
}
//return result
function getFileArray($key, $id, $version){
    $resulFullarray = array();
    $fileArray = scandir('../localizable/'.$id.'/'.$version.'/'.$key, 1);
    for ($i=0; $i < count($fileArray); $i++) {
        if ($fileArray[$i] != '.' && $fileArray[$i] != '..'){
            $file = '../localizable/'.$id.'/'.$version.'/'.$key.'/'.$fileArray[$i];
            if (file_exists($file)) {
                $latestUpdate =  date("Y-M-d'T'H:m:s", filectime($file));
                $object = ['filename'=> $fileArray[$i], 'url'=> 'http://'.$_SERVER['HTTP_HOST'].'/'.'localizable/'.$id.'/'.$version.'/'.$key.'/'.$fileArray[$i], 'latest_update' => $latestUpdate];
                array_push($resulFullarray, $object);
            }
        }
    }
    if(empty($resulFullarray) || count($resulFullarray) == 0){
        return errorMessage('null');
    }else{
        header('HTTP/1.1 200 OK');
        return ['array' => $resulFullarray];
    }
}
//return error message
function errorMessage($key_error){
    if (empty($key_error)){
        return ['message' => 'not found', 'statusCode' => 404 ];
    }else {
        if ($key_error == 'null'){
            header('HTTP/1.1 404 Not Found');
            return ['message' => 'files not fouded', 'statusCode' => 404 ];
        }
        if ($key_error == 'key'){
            header('HTTP/1.1 403 Forbidden');
            return ['message' => 'language key not specified', 'statusCode' => 403 ];
        }
        if ($key_error == 'bundle'){
            header('HTTP/1.1 403 Forbidden');
            return ['message' => 'bundle id not specified', 'statusCode' => 403 ];
        }
        if ($key_error == 'ver'){
            header('HTTP/1.1 403 Forbidden');
            return ['message' => 'version bundle not specified', 'statusCode' => 403 ];
        }
    }
}
 ```
Add example code to 'index.php' and upload on server to API directory.
Next in root directory create directory with name 'localizable'
Next inside 'localizable' create directory with name your bundle id, example 'com.domine.Example'
Next inside 'com.domine.Example' create directory with name your version, example '1.0'
Next inside your version directory create directory with language key name, example 'en'
Last step upload your 'Localizable.plist' file to  need language directory.

Whereupon your will be available api with URL 'http://www.yourdomain.com/api'

### More info
- [Get started](/Documentation/GetStarted.md)
- **Custom configuration -** [Core custom configuration](/Documentation/CustomConfiguration.md),  [Network Custom configuration](/Documentation/NetworkCustomConfiguration.md)
- [Updating files from server](/Documentation/UpdatingFromServer.md)
- [Localized string](/Documentation/LocalizedString.md)
