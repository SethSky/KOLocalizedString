//
//  KOFileManagerConfiguration.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KOFileManagerConfiguration
class KOFileManagerConfiguration: KOFileManagerConfigurationProtocol {
    var manager                 : FileManager
    var directoryName           : String
    var searchPathDirectory     : FileManager.SearchPathDirectory
    var searchPathDomainMask    : FileManager.SearchPathDomainMask
    var isEnableDebug           : Bool
    init(manager: FileManager, directoryName: String, searchPathDirectory: FileManager.SearchPathDirectory, searchPathDomainMask: FileManager.SearchPathDomainMask, isEnableDebug: Bool) {
        self.manager                = manager
        self.directoryName          = directoryName
        self.searchPathDirectory    = searchPathDirectory
        self.searchPathDomainMask   = searchPathDomainMask
        self.isEnableDebug          = isEnableDebug
    }
}
