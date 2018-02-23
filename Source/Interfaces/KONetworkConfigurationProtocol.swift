//
//  KONetworkConfigurationProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
/// KONetworkConfiguration protocol
public protocol KONetworkConfigurationProtocol {
    var session                 : URLSession                            { get }
    var fileNameKey             : String                                { get }
    var urlKey                  : String                                { get }
    var latestUpdateKey         : String                                { get }
    var rootPointKey            : String?                               { get }
    //Request keys // example requestLangKey = "key" || requestBundlekey = "bundle" || requestVersionkey = "ver"
    var requestLangKey          : String?                               { get }
    var requestBundlekey        : String?                               { get }
    var requestVersionkey       : String?                               { get }
    var fileManagerConfiguration: KOFileManagerConfigurationProtocol?   { get }
}
