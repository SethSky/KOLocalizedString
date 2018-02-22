//
//  KONetworkMediator.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//
import Foundation
/// Network mediator with inside file manager
class KONetworkMediator: KONetworkMediatorProtocol {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property public  -
    /// OutSide Bundle
    var outSideBundle           : Bundle?{
        didSet{
            _debug("🔶 Set new outside Bundle for language key [ \(_language ?? "nil") ]")
        }
    }
    /// Call back
    var callback                : NetworkMediatorCallback?
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property private  -
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
    /// language key
    private var _language   : String?{
        didSet{
            if _language != nil && _language != oldValue {
                _didChangeLanguageKey(_language!)
            }
        }
    }
    /// Language command
    private var _languageCommand:[KOMediatorCommandProtocol] = []
    /// Complete block
    private var _completeBlock:((KOLocalizedObjectProtocol)->())?
    /// Complete outside
    var completeUpdate:((String)->())?
    /// Last update files dictionary
    private var _lastUpdate:[String:[KOLocalizedObjectProtocol]] = [:]{
        didSet{
            var dic:[String:[[String:Any]]] = [:]
            for elem in _lastUpdate{
                var array:[[String:Any]] = []
                elem.value.forEach{ array.append($0.getDictionary(_configuration))}
                dic[elem.key] = array
            }
            UserDefaults.standard.set(dic, forKey: KOCoreKeys.lastUpdateKey.rawValue)
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    /// Init
    ///
    /// - Parameters:
    ///   - configuratio: KONetworkConfigurationProtocol
    ///   - url: URL
    ///   - isEnableDebug: Bool
    required init(_ configuration: KONetworkConfigurationProtocol, url: URL, isEnableDebug:Bool ) {
        _url = url
        _isEnableDebug  = isEnableDebug
        _configuration  = configuration
        _networkApi     = KOLocalizedNetwork(isEnableDebug: isEnableDebug, configuration: configuration)
        let builder     = KOFileManagerConfigurationBuilder(configuration: configuration.fileManagerConfiguration!)
        builder.setIsEnableDebug(enable: isEnableDebug)
        _fileManager    = KOFileManager(configuration: builder.create()!)
        _fileManager.callback = { [weak self] state in self?._onStateChange(state) }
        _debugInit(url)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - deinit -
    deinit {
        _debug("----------------------------------------------------------")
        _debug("🔶" + #function + " Network mediator")
        _debug("----------------------------------------------------------")
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Public functions -
    /// Set language key
    ///
    /// - Parameter key: String
    func setLanguageKey(key:String){
         self._language = key
    }
    /// Set is enabel debug
    ///
    /// - Parameter enable: Bool
    public func setIsEnableDebug(enable:Bool){
        self._isEnableDebug = enable
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Private functions -
    /// On state change File Manager
    ///
    /// - Parameter state: FileManagerResult
    private func _commandOnStateChange(_ state:MediatorCommandState){
        switch state {
        case .loadedBundle(let command):
            guard self._language != nil && command.language == self._language! else{ return }
            guard let bundle = command.bundle else{ return }
            self.outSideBundle = bundle
            _lastUpdate[command.language] = command.lastUpdate
            callback?(.loadedBundle(bundle))
            completeUpdate?(command.language)
        case.error(let error):
            callback?(.error(error))
        }
    }
    /// On state change File Manager
    ///
    /// - Parameter state: FileManagerResult
    private func _onStateChange(_ state:FileManagerResult){
        switch state {
        case.error(let error):
            callback?(.error(error))
        default: break
        }
    }
    /// Did change language key
    ///
    /// - Parameter languageKey: String
    private func _didChangeLanguageKey(_ languageKey:String){
        self._versionValidate(languageKey)
        self._lastUpdate = self._createDictionaryLastUpdate(self._configuration)
        let array = _languageCommand.filter({$0.language == languageKey})
        self.outSideBundle = nil
        if let command = array.first {
            if let bundle = command.bundle{
                self.outSideBundle = bundle
                callback?(.loadedBundle(self.outSideBundle!))
            }
            guard command.isComplete else{ return }
            command.execute()
        }else{
            let command = UpdateLanguage(api: _networkApi, fileManager: _fileManager, configuration: _configuration, url: _url, language: languageKey, isEnableDebug: _isEnableDebug)
            command.setLastUpdate(self._lastUpdate[languageKey] ?? [])
            command.callback = { [weak self] state in
                self?._commandOnStateChange(state)
            }
            _languageCommand.append(command)
            command.execute()
        }
    }
    /// Create dictionary last update files with configuration
    ///
    /// - Parameter configuration: KONetworkConfigurationProtocol
    /// - Returns: [String:[KOLocalizedObjectProtocol]]
    private func _createDictionaryLastUpdate(_ configuration: KONetworkConfigurationProtocol)->[String:[KOLocalizedObjectProtocol]]{
        if let value = UserDefaults.standard.value(forKey: KOCoreKeys.lastUpdateKey.rawValue) as? [String:[[String:Any]]]{
            var dic:[String:[KOLocalizedObjectProtocol]] = [:]
            for elem in value{
                var array:[KOLocalizedObjectProtocol] = []
                elem.value.forEach{
                    let builder = KOLocalizedObjectBuilder($0)
                    builder.setConfiguration(configuration)
                    if let obj = builder.create(){
                        array.append(obj)
                    }
                }
                dic[elem.key] = array
            }
            return dic
        }
        return [:]
    }
    /// Version validate
    private func _versionValidate(_ languageKey:String) {
        if let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            if let dic = UserDefaults.standard.value(forKey: KOCoreKeys.versionKey.rawValue) as? [String:String]{
                var newDic = dic
                if let version = dic[languageKey]{
                    if version != currentVersion{
                        _fileManager.removeDirectory(languageKey)
                         newDic[_language!] = currentVersion
                         UserDefaults.standard.setValue(newDic, forKey: KOCoreKeys.versionKey.rawValue)
                    }
                }else{
                    newDic[_language!] = currentVersion
                    UserDefaults.standard.setValue(newDic, forKey: KOCoreKeys.versionKey.rawValue)
                }
            }else{
                UserDefaults.standard.setValue([languageKey:currentVersion], forKey: KOCoreKeys.versionKey.rawValue)
            }
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Debug function -
    /// Debug init
    ///
    /// - Parameters:
    ///   - url: url
    ///   - configuration: configuration
    private func _debugInit(_ url:URL){
        _debug("----------------------------------------------------------")
        _debug("🔶 init Network mediator with URL: \(url.absoluteString)")
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
