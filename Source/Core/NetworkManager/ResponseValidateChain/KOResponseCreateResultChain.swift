//
//  KOResponseCreateResultChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 21.02.2018.
//

import Foundation
/// KOResponseCreateResultChain validate and create result
class KOResponseCreateResultChain: KOResponseValidateChainProtocol {
    var nextChain               : KOResponseValidateChainProtocol?
    private var _configuration  : KONetworkConfigurationProtocol
    init(configuration  : KONetworkConfigurationProtocol) {
        _configuration = configuration
    }
    func getResult(_ response: URLResponse?, _ error: Error?, _ data: Data?) -> HTTPResult {
        do {
            let jsonResult = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            if let array = jsonResult as? [[String : Any]]{
                return HTTPResult.success(array)
            }
            if let dic = jsonResult as? [String : Any] {
                if let array = dic[_configuration.rootPointKey!] as? [[String : Any]]{
                    return HTTPResult.success(array)
                }
            }
            let message = "Content with root key [\(_configuration.rootPointKey ?? "nil")] not found"
            let userInfo = ["NSLocalizedDescription":message]
            let nsError = NSError(domain: KOErrorDomine, code: 404, userInfo: userInfo)
            return HTTPResult.error(nsError)
        }catch let error{
            return HTTPResult.error(error)
        }
    }
}
