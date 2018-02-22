//
//  KOConfigurationBuilder.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
/// Configuration Builder
public class KOConfigurationBuilder: KOConfigurationBuilderProtocol {
    private var _bundle              : Bundle?
    private var _typeFile            : String   = "plist"
    private var _dictionary          : Dictionary<String,Any>?
    private var _defaultLanguageKey  : String?
    private var _fileName            : String   = "Localizable"
    private var _url                 : String?
    private var _isUpdateOutside     : Bool     = false
    private var _isEnableDebug       : Bool     = false
    public init() {}
    internal init(configuration: KOConfigurationProtocol) {
      _bundle               = configuration.bundle
      _typeFile             = configuration.typeFile
      _dictionary           = configuration.dictionary
      _defaultLanguageKey   = configuration.defaultLanguageKey
      _fileName             = configuration.fileName
      _url                  = configuration.url?.absoluteString
      _isUpdateOutside      = configuration.isUpdateOutside
      _isEnableDebug        = configuration.isEnableDebug
    }
    /// Set bundle | only if need set this property
    ///
    /// - Parameter bundle: optional Bundle
    public func setBundle(bundle: Bundle?){
        _bundle = bundle
    }
    /// Set type file, default "plist"
    ///
    /// - Parameter string: String
    public func setTypeFile(string: String){
        _typeFile = string
    }
    /// Set dictionary [String,Any], but if you set this property dictionary have to be [String,String]
    ///
    /// - Parameter dictionary: Dictionary<String,Any>
    public func setDictionary(dictionary: Dictionary<String,Any>?){
        _dictionary = dictionary
    }
    /// set default language Key | example "en"
    ///
    /// - Parameter string: String
    public func setDefaultLanguageKey(string: String){
        _defaultLanguageKey = string
    }
    /// set file name | default "Localizable"
    ///
    /// - Parameter string: String
    public func setFileName(string: String){
        _fileName = string
    }
    /// Set url for destination resource for get response about language files information
    ///
    /// - Parameter string: String
    public func setUrl(string: String){
        _url = string
    }
    /// Set isUpdateOutside default false (not update)
    ///
    /// - Parameter update: Bool
    public func isUpdateOutside(update:Bool){
        _isUpdateOutside = update
    }
    /// Set isEnableDebug default false (not show debug in console)
    ///
    /// - Parameter debug: Bool
    public func isEnableDebug(debug:Bool){
        _isEnableDebug = debug
    }
    /// Create KOConfiguration object
    ///
    /// - Returns: KOConfigurationProtocol
    public func create() -> KOConfigurationProtocol {
        let url = URL(string:_url ?? "")
        return KOConfiguration(bundle: _bundle, typeFile: _typeFile, dictionary: _dictionary, defaultLanguageKey: _defaultLanguageKey, fileName: _fileName, url: url, isUpdateOutside: _isUpdateOutside, isEnableDebug: _isEnableDebug)
    }
}
