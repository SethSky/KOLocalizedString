//
//  KODictionaryChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// Localized chain of responsibility with Dictionary
final class KODictionaryChain:KOLocalizedChainProtocol{
    private var _dictionary: Dictionary<String,Any>
    var nextChain: KOLocalizedChainProtocol?
    /// Get localized string
    ///
    /// - Parameter key: String
    /// - Returns: String
    func getLocalizationString(_ key: String)->String{
        if let value = _dictionary[key] as? String{
            return value
        }else{
            return nextChain?.getLocalizationString(key) ?? key
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    init(_ dictionary: Dictionary<String,Any>) {
        self._dictionary = dictionary
    }
}
