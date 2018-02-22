//
//  KOLocalizedStringChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// Localized chain of responsibility with localizedString 
final class KOLocalizedStringChain:KOLocalizedChainProtocol{
    private var _bundle: Bundle
    var nextChain: KOLocalizedChainProtocol?
    /// Get localized string
    ///
    /// - Parameter key: String
    /// - Returns: String
    func getLocalizationString(_ key: String)->String{
        let value = _bundle.localizedString(forKey: key, value: "", table: nil)
        guard value == key || value == "" else{
            return value
        }
        return nextChain?.getLocalizationString(key) ?? key
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    init(_ bundle: Bundle) {
        self._bundle = bundle
    }
}
