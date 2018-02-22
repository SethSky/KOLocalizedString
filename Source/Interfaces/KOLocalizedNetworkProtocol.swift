//
//  KOLocalizedNetworkProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 17.02.2018.
//

import Foundation
/// KOLocalizedNetwork protocol
protocol KOLocalizedNetworkProtocol {
    init(isEnableDebug:Bool,configuration:KONetworkConfigurationProtocol)
    func responseValidate(_ response:URLResponse?, _ error:Error?, data:Data? ) -> HTTPResult
}
