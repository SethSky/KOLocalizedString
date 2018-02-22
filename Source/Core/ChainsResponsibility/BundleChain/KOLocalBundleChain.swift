//
//  KOLocalBundleChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation 
/// Local bundle chain of responsibility with language key
final class KOLocalBundleChain:KOBundleChainProtocol{
    private var _ofType:String = "lproj"
    var nextChain: KOBundleChainProtocol?
    /// Get Bundle
    ///
    /// - Parameter forKey: String
    /// - Returns: optional Bundle
    func getBundle(_ forKey: String) -> Bundle? {
        if let path = Bundle.main.path(forResource: forKey, ofType: _ofType){
            if let bundle = Bundle(path: path){
                return bundle
            }
        }
        return nextChain?.getBundle(forKey)
    } 
}
