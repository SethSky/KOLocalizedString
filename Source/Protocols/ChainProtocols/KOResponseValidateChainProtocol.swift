//
//  KOResponseValidateChainProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 21.02.2018.
//

import Foundation
/// KOResponseValidateChain protocol
protocol KOResponseValidateChainProtocol {
    /// Next chain optional KOResponseValidateChainProtocol
    var nextChain:KOResponseValidateChainProtocol? { get set }
    /// Get response validate result
    ///
    /// - Parameters:
    ///   - response: optional URLResponse
    ///   - error: optional Error
    ///   - data: optional Data
    /// - Returns: HTTPResult
    func getResult(_ response:URLResponse?, _ error:Error?,_ data:Data?) -> HTTPResult
}
