//
//  KONestedDictionaryChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// Localized chain of responsibility with nested dictionary
final class KONestedDictionaryChain:KOLocalizedChainProtocol{
    private var _dictionary: Dictionary<String,Any>
    var nextChain: KOLocalizedChainProtocol?
    /// Get localized string
    ///
    /// - Parameter key: String
    /// - Returns: String
    func getLocalizationString(_ key: String)->String{
        if let array = _getKeyArray(key){
            if let value = _extractValue(self._dictionary, array){
                return value
            }
            return nextChain?.getLocalizationString(key) ?? key
        }else{
            return nextChain?.getLocalizationString(key) ?? key
        }
    }
    /// Extract value from the dictionary using array
    ///
    /// - Parameters:
    ///   - dictionary: Dictionary<String,Any>
    ///   - array: Array<String>
    /// - Returns: optional String
    private func _extractValue(_ dictionary:Dictionary<String,Any>,_ array: Array<String>)->String?{
        var dic = dictionary
        for elementKey in array {
            if let value  = dic[elementKey] as? String{
                return value
            }
            guard let object = dic[elementKey] as? Dictionary<String,Any> else{ return nil }
            dic = object
        }
        return nil
    }
    /// Get key array
    ///
    /// - Parameter string: String
    /// - Returns: optional Array<String>
    private func _getKeyArray(_ string:String)->Array<String>?{
        let array = string.split{$0 == "."}.map(String.init)
        return array
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    init(_ dictionary: Dictionary<String,Any>) {
        self._dictionary = dictionary
    }
}
