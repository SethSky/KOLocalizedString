//
//  KOKeyChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// Return key
final class KOKeyChain:KOLocalizedChainProtocol{
    var nextChain: KOLocalizedChainProtocol?
    func getLocalizationString(_ key: String)->String{
        return key
    }
}
