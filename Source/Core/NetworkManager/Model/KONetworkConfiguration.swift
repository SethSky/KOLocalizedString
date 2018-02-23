//
//  KONetworkConfiguration.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
/// KONetworkConfiguration
final class KONetworkConfiguration: KONetworkConfigurationProtocol {
    var session                 : URLSession
    var fileNameKey             : String
    var urlKey                  : String
    var latestUpdateKey         : String
    var rootPointKey            : String?
    var requestLangKey          : String?
    var requestBundlekey        : String?
    var requestVersionkey       : String?
    var fileManagerConfiguration: KOFileManagerConfigurationProtocol?
    /// Init session:URLSession, fileNameKey:String, urlKey:String, latestUpdateKey: String, rootPointKey:String?
    ///
    /// - Parameters:
    ///   - session: URLSession
    ///   - fileNameKey: String
    ///   - urlKey: String
    ///   - latestUpdateKey: String
    ///   - rootPointKey: optional String
    init(session:URLSession, fileNameKey:String, urlKey:String, latestUpdateKey: String,  rootPointKey:String?,requestLangKey: String?, requestBundlekey: String? , requestVersionkey: String?, fileManagerConfiguration:KOFileManagerConfigurationProtocol?) {
        self.session                    = session
        self.fileNameKey                = fileNameKey
        self.urlKey                     = urlKey
        self.latestUpdateKey            = latestUpdateKey
        self.rootPointKey               = rootPointKey
        self.requestLangKey             = requestLangKey
        self.requestBundlekey           = requestBundlekey
        self.requestVersionkey          = requestVersionkey
        self.fileManagerConfiguration   = fileManagerConfiguration
    }
}
