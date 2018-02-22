//
//  KOLocalizedChainProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
///  Localized chain of responsibility protocol
internal protocol KOLocalizedChainProtocol {
    var nextChain:KOLocalizedChainProtocol? { get set }
    func getLocalizationString(_ forKey:String)->String
}
