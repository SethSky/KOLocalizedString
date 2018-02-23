//
//  KOFileManagerConfigurationBuilderProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KOFileManagerConfigurationBuilder protocol
protocol KOFileManagerConfigurationBuilderProtocol {
    func setManager(manager:FileManager)
    func setDirectoryName(string:String)
    func setSearchPathDirectory(directory:FileManager.SearchPathDirectory)
    func setSearchPathDomainMask(domainMask:FileManager.SearchPathDomainMask)
    func setIsEnableDebug(enable:Bool)
    func create()->KOFileManagerConfigurationProtocol?
}
