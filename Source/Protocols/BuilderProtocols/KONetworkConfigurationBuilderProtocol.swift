//
//  KONetworkConfigurationBuilderProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
/// KONetworkConfiguration builder protocol
public protocol KONetworkConfigurationBuilderProtocol{
    func setSession(session:URLSession)
    func setFileNameKey(string:String)
    func setUrlKey(string:String)
    func setLatestUpdateKey(string:String)
    func setRootPointKey(string: String?)
    //
    func setRequestLangKey(string: String?)
    func setRequestBundlekey(string: String?)
    func setRequestVersionkey(string: String?)
    func setFileManagerConfiguration(configuration:KOFileManagerConfigurationProtocol)
    //
    func create() -> KONetworkConfigurationProtocol
}
