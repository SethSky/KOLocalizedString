//
//  KOLocalizedObjectProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// KOLocalizedObjectProtocol
internal protocol KOLocalizedObjectProtocol{
    var fileName        : String    { get }
    var url             : URL       { get }
    var latestUpdate    : String    { get }
}

extension KOLocalizedObjectProtocol{
    func isEqualTo(_ other: KOLocalizedObjectProtocol) -> Bool {
        return self.fileName == other.fileName && self.latestUpdate == other.latestUpdate && self.url == other.url
    }
    func getDictionary(_ configuration: KONetworkConfigurationProtocol) -> Dictionary<String,Any> {
        var dic = Dictionary<String,Any>()
        dic[configuration.fileNameKey] = self.fileName
        dic[configuration.latestUpdateKey] = self.latestUpdate
        dic[configuration.urlKey] = self.url.absoluteString
        return dic
    }
} 
