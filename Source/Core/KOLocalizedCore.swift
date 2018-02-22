//
//  KOLocalizedCore.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//
import Foundation
/// Helper for change language your app, without rebooting app
public class KOLocalizedCore{
    //Shared instance
    public static let main = KOLocalizedCore()
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property -
    private var _configuration  : KOConfigurationProtocol?
    private var _networkMediator: KONetworkMediatorProtocol?
    public var currentBundle    : Bundle?{ return _configuration?.bundle }
    /// Error callback
    public var errorCallback    : ((Error)->())?
    /// Complete callback for outside bundle return language key
    public var completeUpdate   : ((String)->())?{
        didSet{
            _networkMediator?.completeUpdate = completeUpdate
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    private init(){}
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Configuration -
    /// configure with KOConfiguration if nil create default configuration
    ///
    /// - Parameter configuration: optional KOConfigurationProtocol
    public func configureWith(_ configuration:KOConfigurationProtocol?){
        guard configuration != nil else { self.configure(); return }
        _configuration = configuration
        _setBundle(_getBundle(configuration?.defaultLanguageKey ?? currentLanguageKey()))
        /// If save last used dictionary get value from key
        if let lastDic = UserDefaults.standard.value(forKey: KOCoreKeys.lastDictionaryKey.rawValue) as? NSDictionary{
            _setDictionary(lastDic as? Dictionary<String, Any>)
        }
        guard let languageKey =  UserDefaults.standard.value(forKey:KOCoreKeys.localeKey.rawValue) as? String else {
            _setDictionary(_updateDictionary() as? Dictionary<String, Any>)
            self.setLanguage(_configuration?.defaultLanguageKey)
            _debug("💡 LocalizedCore: Create custom configuration")
            return
        }
        let configurationBuilder = KOConfigurationBuilder(configuration: configuration!)
        configurationBuilder.setDefaultLanguageKey(string: languageKey) 
        _configuration = configurationBuilder.create()
        _debug("💡 LocalizedCore: Create custom configuration with seved language key:[ \(languageKey) ]")
        self.setLanguage((_configuration?.defaultLanguageKey!)!)
        guard configuration?.isUpdateOutside ?? false else { return }
        //_networkConfigure()
    }
    /// Default configuration
    public func configure(){
        let configurationBuilder = KOConfigurationBuilder()
        /// If save last used dictionary get value from key
        if let lastDic = UserDefaults.standard.value(forKey: KOCoreKeys.lastDictionaryKey.rawValue) as? NSDictionary{
            configurationBuilder.setDictionary(dictionary: lastDic as? Dictionary<String, Any>)
        }
        guard let languageKey =  UserDefaults.standard.value(forKey:KOCoreKeys.localeKey.rawValue) as? String else {
            _configuration = KOConfigurationBuilder().create()
            _setBundle(_getBundle(currentLanguageKey()))
            _debug("💡 LocalizedCore: Create default configuration")
            return
        }
        configurationBuilder.setDefaultLanguageKey(string: languageKey)
        _configuration = configurationBuilder.create()
        _debug("💡 LocalizedCore: Create default configuration with seved language key:[ \(languageKey) ]")
        self.setLanguage((_configuration?.defaultLanguageKey!)!)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Network configuration -
    public func networkConfigure(_ configuration:KONetworkConfigurationProtocol?){
        guard _configuration?.isUpdateOutside ?? false else { return }
        guard let url = _configuration?.url else { debugPrint("⚠️ |KOLocalizedCore|==| Need add URL)"); return }
        guard configuration != nil else { _networkConfigure() ; return }
        _debug("💡 LocalizedCore: Create custom network configuration")
        _networkMediator = KONetworkMediator(configuration!, url:url, isEnableDebug: (_configuration?.isEnableDebug)!)
        _networkMediator?.setLanguageKey(key: currentLanguageKey())
        _networkMediator?.callback = { [unowned self] state in
            self._onStateChange(state)
        }
        
    }
    /// Default network configure
    private func _networkConfigure(){
        guard _configuration?.isUpdateOutside ?? false else { return }
        guard let url = _configuration?.url, _networkMediator == nil else { return }
        _debug("💡 LocalizedCore: Create default network configuration")
        let networkConfiguration = KONetworkConfigurationBuilder().create()
        _networkMediator = KONetworkMediator(networkConfiguration, url:url, isEnableDebug: (_configuration?.isEnableDebug)!)
        _networkMediator?.setLanguageKey(key: currentLanguageKey())
        _networkMediator?.callback = { [unowned self] state in
            self._onStateChange(state)
        }
    }
    /// On state change network mediator
    ///
    /// - Parameter state: LocalizationNetworkState
    private func _onStateChange(_ state:LocalizationNetworkState){
        switch state {
        case .loadedBundle(let bundle):
            _setBundle(bundle)
        case.error(let error):
             errorCallback?(error)
        default:break
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Language Dictionary -
    /// Update Dictionary
    private func _updateDictionary()->NSDictionary?{
        if let path = _configuration?.bundle?.path(forResource: _configuration?.fileName, ofType: _configuration?.typeFile){
            return NSDictionary(contentsOfFile: path)!
        }
        return nil
    }
    /// Set dictionary
    ///
    /// - Parameter dictionary: Dictionary<String,Any>
    private func _setDictionary(_ dictionary:Dictionary<String,Any>?){
        guard dictionary != nil else { return }
        _configuration?.dictionary = dictionary
        UserDefaults.standard.setValue(dictionary! as NSDictionary, forKey: KOCoreKeys.lastDictionaryKey.rawValue)
        NotificationCenter.default.post(name: .KODidUpdateDictionary, object: nil)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Bundles -
    /// Set Bundle, if self bundle is nil set main Bundle
    ///
    /// - Parameter bundle: Bundle optional
    private func _setBundle(_ bundle:Bundle?){
        _configuration?.bundle = bundle ?? Bundle.main
        _setDictionary(_updateDictionary() as? Dictionary<String, Any>)
        NotificationCenter.default.post(name: .KODidUpdateBundle, object: nil)
    }
    /// Get bundle with language key
    ///
    /// - Parameter languageKey: String
    /// - Returns: Bundle
    private func _getBundle(_ languageKey:String)->Bundle{
        let outSideBundleChain          = KOOutSideBundleChain(_configuration?.isUpdateOutside ?? false, mediator: _networkMediator)
        let localBundleChain            = KOLocalBundleChain()
        let defaultBundleChain          = KODefaultBundleChain()
        outSideBundleChain.nextChain    = localBundleChain
        localBundleChain.nextChain      = defaultBundleChain
        return outSideBundleChain.getBundle(languageKey)!
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - work with language keys
    /// Get localized string for key
    ///
    /// - Parameter key: key String
    /// - Returns: value String
    internal func localizedStringForKey(_ key:String) -> String {
        guard _configuration != nil else {
            debugPrint("⚠️ |KOLocalizedCore|==| Need create default configuration (KOLocalizedCore.main.configure())")
            return key
        }
        let localizedStringChain        = KOLocalizedStringChain((_configuration?.bundle)!)
        let dictionaryChain             = KODictionaryChain(_configuration?.dictionary ?? [:])
        let nestedDictionaryChain       = KONestedDictionaryChain(_configuration?.dictionary ?? [:])
        let keyChain                    = KOKeyChain()
        
        localizedStringChain.nextChain  = dictionaryChain
        dictionaryChain.nextChain       = nestedDictionaryChain
        nestedDictionaryChain.nextChain = keyChain
        guard  _configuration?.isEnableDebug ?? false  else {
            return localizedStringChain.getLocalizationString(key)
        }
        let value =  localizedStringChain.getLocalizationString(key)
        _debug("💡 LocalizedCore: get localizedString for language key: [ \(key) ] return value:[\(value)]")
        return value
    }
    /// Set language
    ///
    /// - Parameter lang: String
    internal func setLanguage(_ key:String?){
        _debug("💡 LocalizedCore: Set new language key: [ \(key ?? "nil") ]")
        guard key != nil else { return }
        UserDefaults.standard.setValue(key, forKey: KOCoreKeys.localeKey.rawValue)
        let configurationBuilder = KOConfigurationBuilder(configuration: _configuration!)
        configurationBuilder.setDefaultLanguageKey(string: key!)
        _configuration = configurationBuilder.create()
        _networkMediator?.setLanguageKey(key: key!)
        _setBundle(_getBundle(key!))
        NotificationCenter.default.post(name: .KODidChangeLanguage, object: nil)
    }
    /// Current language key
    ///
    /// - Returns: return key current language
    internal func currentLanguageKey() -> String {
        let key = _configuration?.defaultLanguageKey ?? Locale.current.languageCode!
        _debug("💡 LocalizedCore: Get current language key: [ \(key) ]")
        return key
    }
    /// Debug print
    ///
    /// - Parameter items: Any
    private func _debug(_ items:Any...){
        guard let isEnableDebug = _configuration?.isEnableDebug, isEnableDebug else { return }
         debugPrint(items)
    }
}
