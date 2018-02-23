//
//  UpdateLanguage.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 22.02.2018.
//

import Foundation
/// Update language command
class UpdateLanguage:KOMediatorCommandProtocol{
    /// Language key
    var language                : String
    /// is complete load language
    var isComplete              : Bool  = false
    /// Updating files
    var lastUpdate              : [KOLocalizedObjectProtocol] = []
    /// Callback
    var callback                : ((MediatorCommandState)->())?
    /// Out side bundle
    var bundle                  : Bundle?
    /// is enabel debug
    private var _isEnableDebug  : Bool = false
    /// resource url
    private var _url            : URL
    /// metwork api KOLocalizedNetwork
    private var _networkApi     : KOLocalizedNetwork
    /// File manager
    private var _fileManager    : KOFileManagerProtocol
    /// Network configuration
    private var _configuration  : KONetworkConfigurationProtocol
    /// Complete block
    private var _completeBlock  : ((KOLocalizedObjectProtocol)->())?
//    //Semaphore
//    private var _semaphore      : DispatchSemaphore
    //
    private var _queue          : DispatchQueue
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    init(api:KOLocalizedNetwork,fileManager: KOFileManagerProtocol, configuration: KONetworkConfigurationProtocol, url:URL, language:String, isEnableDebug:Bool) {
        //_semaphore      = DispatchSemaphore(value: 1)
        _queue          = DispatchQueue(label: "UpdateLanguage_" + language, qos: DispatchQoS.background, attributes: .concurrent)
        self.language   = language
        _url            = url
        _networkApi     = api
        _fileManager    = fileManager
        _configuration  = configuration
        _isEnableDebug  = isEnableDebug
        _debugInit(language)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - deinit -
    deinit {
        _debug("----------------------------------------------------------")
        _debug("🔶" + #function + " UpdateLanguage Command")
        _debug("----------------------------------------------------------")
    }
    /// Set Last update KOLocalizedObjectProtocol
    ///
    /// - Parameter lastUpdate: [KOLocalizedObjectProtocol]
    func setLastUpdate(_ lastUpdate:[KOLocalizedObjectProtocol]){
        self.lastUpdate = lastUpdate
    }
    /// Execute
    func execute(){
        _queue.async {
            self._getLanguageList(self._url, laguageKey: self.language)
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Network function -
    /// Get language list
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - laguageKey: String
    private func _getLanguageList(_ url:URL, laguageKey:String){
        _networkApi.getLanguageList(url, key: laguageKey) { [weak self] (result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let array):
                weakSelf._debugPotentialDownloadsList(array, laguageKey: laguageKey)
                weakSelf._validateObjects(array,laguageKey)
            case .error(let error):
                weakSelf.isComplete = true
                weakSelf.callback?(.error(error))
            }
        }
    }
    /// Download file
    ///
    /// - Parameter object: KOLocalizedObjectProtocol
    private func _downloadFile(_ object:KOLocalizedObjectProtocol, language:String){
        _networkApi.getFilePath(object.url) { [weak self] (result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let localUrl):
                _ = weakSelf._fileManager.moveToTempLanguageFolder(object, url: localUrl, key: language)
                weakSelf._debugDownloadFile(object, laguageKey: language)
                weakSelf._completeBlock?(object)
            case .error(let error):
                weakSelf.callback?(.error(error))
            }
        }
    }
    /// Validate objects
    ///
    /// - Parameter array: KOLocalizedObjectProtocol array
    private func _validateObjects(_ array:[KOLocalizedObjectProtocol],_ languageKey:String){
        let oldArray = lastUpdate
        var newArray = _createToUpdatingArray(oldArray: oldArray, newArray: array)
        guard newArray.count > 0 else {
            self._getBundle(languageKey)
            self.isComplete = true
            return
        }
        if let obj = newArray.last{
            self._downloadFile(obj, language: languageKey)
        }
        _completeBlock = { [weak self] (object) in
            guard let weakSelf = self else { return }
            newArray = newArray.filter{!$0.isEqualTo(object)}
            if let last = newArray.last{
                weakSelf._downloadFile(last, language: languageKey)
            }else{
                if weakSelf._fileManager.moveLanguageFolderFromTemp(languageKey){
                    weakSelf._getBundle(languageKey)
                    weakSelf.lastUpdate = array
                    weakSelf.isComplete = true
                }else{
                    weakSelf.isComplete = true
                }
            }
        }
    }
    /// Create to updating array
    ///
    /// - Parameters:
    ///   - oldArray: [KOLocalizedObjectProtocol]
    ///   - newArray: [KOLocalizedObjectProtocol]
    /// - Returns: [KOLocalizedObjectProtocol]
    private func _createToUpdatingArray(oldArray:[KOLocalizedObjectProtocol], newArray:[KOLocalizedObjectProtocol]) -> [KOLocalizedObjectProtocol] {
        let newSet = Set(newArray as! [KOLocalizedObject]).subtracting(oldArray as! [KOLocalizedObject])
        var arr:[KOLocalizedObject] = []
        var iterator = newSet.makeIterator()
        while let element = iterator.next(){
            arr.append(element)
        }
        return arr
    }
    /// Get bundle
    private func _getBundle(_ key:String){
        if let bundle = _fileManager.getBundle(key){
            _queue.sync {
                    self.bundle = bundle
                    self.callback?(.loadedBundle(self))
            }
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Debug function -
    private func _debugDownloadFile(_ object:KOLocalizedObjectProtocol, laguageKey:String){
        _debug("----------------------------------------------------------")
        _debug("🔹 Downloading file: \(object.fileName) for language: [ \(laguageKey) ]complete")
        _debug("----------------------------------------------------------")
    }
    /// Potential downloads list
    ///
    /// - Parameters:
    ///   - array: [KOLocalizedObjectProtocol]
    ///   - laguageKey: String
    private func _debugPotentialDownloadsList(_ array:[KOLocalizedObjectProtocol], laguageKey:String){
        _debug("----------------------------------------------------------")
        _debug("🔹 Potential downloads list:")
        _debug("----------------------------------------------------------")
        for obj in array{
            _debug("🔹 file: \(obj.fileName) for language: \(laguageKey)")
        }
        _debug("----------------------------------------------------------")
    }
    /// Debug init
    ///
    /// - Parameters:
    ///   - url: url
    ///   - configuration: configuration
    private func _debugInit(_ language:String){
        _debug("----------------------------------------------------------")
        _debug("🔶 init UpdateLanguage Command for language: [ \(language) ]")
        _debug("----------------------------------------------------------")
    }
    /// Debug print
    ///
    /// - Parameter items: Any
    private func _debug(_ items:Any...){
        guard _isEnableDebug else { return }
        debugPrint(items)
    }
}
