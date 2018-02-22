//
//  KOResponseValidateChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 21.02.2018.
//

import Foundation
/// KOResponseValidateChain validate on http response
class KOResponseValidateChain: KOResponseValidateChainProtocol {
    var nextChain: KOResponseValidateChainProtocol?
    func getResult(_ response: URLResponse?, _ error: Error?, _ data: Data?) -> HTTPResult {
        let userInfo = ["NSLocalizedDescription":"extract response is failure"]
        guard let httpResponse = response as? HTTPURLResponse else {
            let nsError = NSError(domain: KOErrorDomine, code: 1004, userInfo: userInfo)
            return HTTPResult.error(nsError)
        }
        guard httpResponse.statusCode == 200 else {
            let nsError = NSError(domain: KOErrorDomine, code:  httpResponse.statusCode, userInfo: userInfo)
            return HTTPResult.error(nsError)
        }
        return (nextChain?.getResult(response, error, data))!
    }
}
