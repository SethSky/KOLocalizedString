//
//  KOLocalizedObjectBuilderProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// KOLocalizedObjectBuilder Protocol
internal protocol KOLocalizedObjectBuilderProtocol{
    func setFileName(_ string:String)
    func setUrl(_ string:String)
    func setLatestUpdate(_ string:String)
}
