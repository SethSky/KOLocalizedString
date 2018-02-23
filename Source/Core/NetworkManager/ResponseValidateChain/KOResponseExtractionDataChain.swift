//
//  KOResponseExtractionDataChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 21.02.2018.
//

import Foundation
/// KOResponseExtractionDataChain validate on data
class KOResponseExtractionDataChain: KOResponseValidateChainProtocol {
    var nextChain: KOResponseValidateChainProtocol?
    func getResult(_ response: URLResponse?, _ error: Error?, _ data: Data?) -> HTTPResult {
        guard data != nil else {
            let userInfo = ["NSLocalizedDescription":"Content not found"]
            let nsError = NSError(domain: KOErrorDomine, code: 404, userInfo:userInfo)
            return HTTPResult.error(nsError)
        }
        return (nextChain?.getResult(response, error, data))!
    }
    
}
