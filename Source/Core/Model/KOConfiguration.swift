//
//  KOConfiguration.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
/// Configuration object
final class KOConfiguration:KOConfigurationProtocol{
    var bundle              : Bundle?
    var typeFile            : String
    var dictionary          : Dictionary<String, Any>?
    var defaultLanguageKey  : String?
    var fileName            : String
    var url                 : URL?
    var isUpdateOutside     : Bool
    var isEnableDebug       : Bool
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    init(bundle: Bundle?, typeFile: String, dictionary: Dictionary<String, Any>?, defaultLanguageKey: String?, fileName: String, url: URL?, isUpdateOutside: Bool, isEnableDebug: Bool) {
        self.bundle                 = bundle
        self.typeFile               = typeFile
        self.dictionary             = dictionary
        self.defaultLanguageKey     = defaultLanguageKey
        self.fileName               = fileName
        self.url                    = url
        self.isUpdateOutside        = isUpdateOutside
        self.isEnableDebug          = isEnableDebug
    } 
}
