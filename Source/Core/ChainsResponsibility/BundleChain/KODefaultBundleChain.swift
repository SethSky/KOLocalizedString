//
//  KODefaultBundleChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// Default bundle chain of responsibility with language key
final class KODefaultBundleChain:KOBundleChainProtocol{
    var nextChain: KOBundleChainProtocol?
    /// Get Bundle
    ///
    /// - Parameter forKey: String
    /// - Returns: optional Bundle
    func getBundle(_ forKey: String) -> Bundle? {
        return Bundle.main
    }
}
