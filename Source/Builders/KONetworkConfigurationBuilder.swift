//
//  KONetworkConfigurationBuilder.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
/// KONetworkConfiguration builder
public final class KONetworkConfigurationBuilder: KONetworkConfigurationBuilderProtocol {
    private var _session                    : URLSession = URLSession(configuration: URLSessionConfiguration.default)
    private var _fileNameKey                : String     = "filename"
    private var _urlKey                     : String     = "url"
    private var _latestUpdateKey            : String     = "latest_update"
    private var _rootPointKey               : String?    = "array"
    private var _requestLangKey             : String?    = "key"
    private var _requestBundlekey           : String?    = "bundle"
    private var _requestVersionkey          : String?    = "ver"
    private var _fileManagerConfiguration   : KOFileManagerConfigurationProtocol?
    public init() { }
    /// Set session
    ///
    /// - Parameter session: URLSession
    public func setSession(session: URLSession) {
        _session = session
    }
    /// Set fileNameKey
    ///
    /// - Parameter string: string
    public func setFileNameKey(string: String) {
        _fileNameKey = string
    }
    /// Set urlKey
    ///
    /// - Parameter string: String
    public func setUrlKey(string: String) {
        _urlKey = string
    }
    /// Set latestUpdateKey
    ///
    /// - Parameter string: String
    public func setLatestUpdateKey(string: String) {
        _latestUpdateKey = string
    }
    /// Set rootPointKey optional
    ///
    /// - Parameter string: optional String
    public func setRootPointKey(string: String?) {
        guard string != nil else { return  }
        _rootPointKey = string
    }
    /// Set request language key
    ///
    /// - Parameter string: optional String
    public func setRequestLangKey(string: String?) {
         guard string != nil else { return  }
        _requestLangKey = string
    }
    /// Set request Bundle key
    ///
    /// - Parameter string: optional String
    public func setRequestBundlekey(string: String?) {
         guard string != nil else { return  }
        _requestBundlekey = string
    }
    /// Set request version build key
    ///
    /// - Parameter string: optional String
    public func setRequestVersionkey(string: String?) {
         guard string != nil else { return  }
        _requestVersionkey = string
    }
    /// Set file manager configuration
    ///
    /// - Parameter configuration: KOFileManagerConfigurationProtocol
    public func setFileManagerConfiguration(configuration:KOFileManagerConfigurationProtocol){
        _fileManagerConfiguration = configuration
    }
    /// Create KONetworkConfiguration
    ///
    /// - Returns: KONetworkConfigurationProtocol
    public func create() -> KONetworkConfigurationProtocol {
        let builder = KOFileManagerConfigurationBuilder()
        return KONetworkConfiguration(session: _session, fileNameKey: _fileNameKey, urlKey: _urlKey, latestUpdateKey: _latestUpdateKey, rootPointKey: _rootPointKey, requestLangKey: _requestLangKey, requestBundlekey: _requestBundlekey, requestVersionkey: _requestVersionkey, fileManagerConfiguration: _fileManagerConfiguration ?? builder.create()!)
    }
}
