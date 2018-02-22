//
//  KOConfigurationProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
/// Configuration protocol
public protocol KOConfigurationProtocol {
    // Current bundle
    var bundle              : Bundle?                   {get set}
    /// File type
    var typeFile            : String                    {get}
    /// Localized dictionary
    var dictionary          : Dictionary<String,Any>?   {get set}
    /// Default language key
    var defaultLanguageKey  : String?                   {get}
    /// Default language key
    var fileName            : String                    {get}
    /// URL to outside api
    var url                 : URL?                      {get}
    /// Is update outside. default false
    var isUpdateOutside     : Bool                      {get}
    /// Is debug. default false
    var isEnableDebug       : Bool                      {get}
}
