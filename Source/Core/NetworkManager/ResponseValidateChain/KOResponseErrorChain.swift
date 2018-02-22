//
//  KOResponseErrorChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 21.02.2018.
//

import Foundation
/// KOResponseErrorChain Validate on Errors
class KOResponseErrorChain: KOResponseValidateChainProtocol {
    //
    var nextChain: KOResponseValidateChainProtocol?
    //
    func getResult(_ response: URLResponse?, _ error: Error?,_ data: Data?) -> HTTPResult {
        guard error == nil else { return HTTPResult.error(error!)}
        return (nextChain?.getResult(response, error, data))!
    }
}
