//
//  KOConfigurationBuilderProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 16.02.2018.
//

import Foundation
///  Configuration builder protocol
public protocol KOConfigurationBuilderProtocol {
    func setBundle(bundle: Bundle?)
    func setTypeFile(string: String)
    func setDictionary(dictionary: Dictionary<String,Any>?)
    func setDefaultLanguageKey(string: String)
    func setFileName(string: String)
    func setUrl(string: String)
    func isUpdateOutside(update:Bool)
    func isEnableDebug(debug:Bool)
}
