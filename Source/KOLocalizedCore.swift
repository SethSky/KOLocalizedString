//
//  KOLocalizedCore.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//
import Foundation
/// Helper for change language your app, without rebooting app
class KOLocalizedCore{
    //Shared instance
    static let main = KOLocalizedCore()
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Keys -
    //––––––––––––––––––––––––––––––––––––––––
    /// Localized dictionary
    internal var lastDictionaryKey          : String = "kLastDictionaryKey"
    ///Set locale key
    internal let localeKey                  : String = "kSetLocaleKey"
    ///Set locale key
    internal let versionKey                 : String = "kVersionKey"
    ///Set locale key
    internal let keysArrayKey               : String = "kKeysArrayKey"
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property -
    //––––––––––––––––––––––––––––––––––––––––
    //Current bundle
    internal var bundle                     : Bundle!
    /// File type
    static private let typeFile             : String = "plist"
    /// Localized dictionary
    internal var localizedDictionary        : NSDictionary?{
        didSet {
            if localizedDictionary == nil {
                return
            }
            UserDefaults.standard.setValue(localizedDictionary, forKey: lastDictionaryKey)
            NotificationCenter.default.post(name: .KODidUpdateDictionary, object: nil)
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Settings property -
    //––––––––––––––––––––––––––––––––––––––––
    //Is update outside. default false
    public var isUpdateOutside              : Bool   = true
    //Is debug. default false
    public var isEnabelDebug                : Bool   = true{
        didSet{
            fileManager.isEnabelDebug = isEnabelDebug
        }
    }
    /// Default language key
    public var fileName                     : String = "Localizable"
    //URL to outside api
    public var url                          : String!{
        didSet{
            if url != nil{
                if isUpdateOutside{
                    setupNetworkManager()
                }
            }
        }
    }
    /// Default language key
    public var defaultLanguageKey           : String?
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Manager property -
    //––––––––––––––––––––––––––––––––––––––––
    ///File manager for outside update language resourses
    private var fileManager                 : KOLocalizedFileManager!
    //Network manager
    private var networtManager              : KOLocalizedNetwork!
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    //––––––––––––––––––––––––––––––––––––––––
    //Init
    init() {
        self.fileManager = createFileManager()
        settings()
    }
    /// Create file manager
    ///
    /// - Returns: KOLocalizedFileManager
    private func createFileManager() -> KOLocalizedFileManager {
        return KOLocalizedFileManager(isEnabelDebug)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Settings -
    //––––––––––––––––––––––––––––––––––––––––
    private func settings(){
        checkVersionBuild()
        if let languageKey =  UserDefaults.standard.value(forKey: localeKey) as? String{
            defaultLanguageKey = languageKey
        }
        guard defaultLanguageKey == nil else {
            self.setLanguage(defaultLanguageKey!)
            return
        }
        //Set Default Bundle
        setBundle(self.bundle)
        /// If save last used dictionary get value from key
        if let lastDic = UserDefaults.standard.value(forKey: lastDictionaryKey) as? NSDictionary{
            self.localizedDictionary = lastDic
        }
        self.localizedDictionary = updateDictionary()
    }
    /// Check build version
    private func checkVersionBuild(){
        if let version = UserDefaults.standard.value(forKey: versionKey) as? String{
            if let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                if version != currentVersion{
                    fileManager.removeDirectory(nil)
                    removeFileKeys()
                    UserDefaults.standard.removeObject(forKey: lastDictionaryKey)
                    UserDefaults.standard.setValue(currentVersion, forKey: versionKey)
                }
            }
        }else{
            if let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                UserDefaults.standard.setValue(currentVersion, forKey: versionKey)
            }
        }
    }
    /// Set Bundle, if self bundle is nil set main Bundle
    ///
    /// - Parameter bundle: Bundle optional
    private func setBundle(_ bundle:Bundle?){
        self.bundle = bundle ?? Bundle.main
        NotificationCenter.default.post(name: .KODidUpdateBundle, object: nil)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - work with language keys
    //––––––––––––––––––––––––––––––––––––––––
    /// Get localized string for key
    ///
    /// - Parameter key: key String
    /// - Returns: value String
    internal func localizedStringForKey(_ key:String) -> String {
        guard localizedDictionary == nil else {
            return valueWith(key:key)
        }
        return bundle.localizedString(forKey: key, value: "", table: nil)
    }
    /// Get value by key. if key not found return key as value
    ///
    /// - Parameter key: key for search value in dictionary
    /// - Returns: return value or key if not found key in dictionary
    private func valueWith(key:String) -> String {
        guard localizedDictionary != nil else {
            return key
        }
        return localizedDictionary!.object(forKey: key) as? String ?? key
    }
    /// Set language
    ///
    /// - Parameter lang: String
    internal func setLanguage(_ key:String){
        self.defaultLanguageKey = key
        UserDefaults.standard.setValue(key, forKey: localeKey)
        self.setBundle(getBundleWithKey(key))
        self.localizedDictionary = updateDictionary()
        setupNetworkManager()
        NotificationCenter.default.post(name: .KODidChangeLanguage, object: nil)
    }
    /// Current language key
    ///
    /// - Returns: return key current language
    internal func currentLanguageKey() -> String {
        return defaultLanguageKey ?? Locale.current.languageCode!
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Language Dictionary, Bundles -
    //––––––––––––––––––––––––––––––––––––––––
    /// Update Dictionary
    private func updateDictionary()->NSDictionary?{
        if let path = bundle.path(forResource: fileName, ofType: KOLocalizedCore.typeFile){
            return NSDictionary(contentsOfFile: path)!
        }
        return nil
    }
    /// Get bundle with key
    ///
    /// - Parameter key: String
    /// - Returns: Bundle
    internal func getBundleWithKey(_ key:String)->Bundle?{
        if let outSideBundle = getOutSideBundle(key){
            return outSideBundle
        }
        if let path = Bundle.main.path(forResource: key, ofType: "lproj"){
            if let newBundle = Bundle(path: path){
                return newBundle
            }
        }
        return nil
    }
    /// Get out side Bundle
    ///
    /// - Parameters:
    ///   - url: URL or nil
    ///   - key: key
    /// - Returns: Bundle or nil
    internal func getOutSideBundle(_ key:String)->Bundle?{
        guard let newBundle = fileManager.getOutsideBundleWithKey(key, countFiles:nil) else {
             return nil
        }
        return newBundle
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Network -
    //––––––––––––––––––––––––––––––––––––––––
    /// Setup network manager
    @objc private func setupNetworkManager(){
        guard  url != nil else { return }
        networtManager = KOLocalizedNetwork(url)
        networtManager.isEnabelDebug = isEnabelDebug
        getInfoWithLanguageKey(defaultLanguageKey ?? currentLanguageKey())
    }
    /// Get info with language key
    ///
    /// - Parameter key: String
    private func getInfoWithLanguageKey(_ key:String){
        networtManager.getInfoWithKey(key, success: { (objects) in
            self.getFiles(objects,key)
        }, failure: { (error) in
            Timer.scheduledTimer(timeInterval:10, target: self, selector: #selector(self.setupNetworkManager), userInfo: nil, repeats: false)
        })
    }
    /// get files with KOLocalized Objects Array and language key
    ///
    /// - Parameters:
    ///   - array: Array<KOLocalizedObject>
    ///   - languageKey: String
    private func getFiles(_ array:Array<KOLocalizedObject>,_ languageKey:String){
        for (index, object) in array.enumerated(){
            networtManager.getTempLocalURL(object, fileUrl: { (url) in
                self.fileManager.saveFile(object, url: url, languageKey)
                if index == (array.count - 1){
                    if let bundel = self.fileManager.getOutsideBundleWithKey(languageKey, countFiles: array.count){
                        self.setBundle(bundel)
                        self.localizedDictionary = self.updateDictionary()
                        self.saveKeysWithArray(self.fileManager.getKeysArray())
                    }
                }
            }, failure: { (error) in
                self.getFiles(array, languageKey)
            })
        }
    }
    /// Remove file keys
    private func removeFileKeys(){
        if let array = UserDefaults.standard.array(forKey: keysArrayKey) as? Array<String>{
            for key in array{
                UserDefaults.standard.removeObject(forKey: key)
            }
            UserDefaults.standard.removeObject(forKey: keysArrayKey)
        }
    }
    /// Save keys with array
    ///
    /// - Parameter array: Array<String>
    private func saveKeysWithArray(_ array:Array<String>){
        if let oldArray = UserDefaults.standard.object(forKey: keysArrayKey) as? Array<String>{
            var newArray:Array<String> = []
            for key in array{
                var tempKey:String?
                for oKey in oldArray{
                    if key == oKey{ tempKey = oKey }
                }
                if tempKey == nil{ newArray.append(key)}
            }
            newArray.append(contentsOf: oldArray)
            UserDefaults.standard.set(newArray, forKey: keysArrayKey)
        }else{
            UserDefaults.standard.set(array, forKey: keysArrayKey)
        }
    }
}
