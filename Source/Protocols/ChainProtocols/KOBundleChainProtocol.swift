//
//  KOBundleChainProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// Bundle chain of responsibility protocol
internal protocol KOBundleChainProtocol {
    var nextChain:KOBundleChainProtocol? { get set }
    func getBundle(_ forKey:String)->Bundle?
}
