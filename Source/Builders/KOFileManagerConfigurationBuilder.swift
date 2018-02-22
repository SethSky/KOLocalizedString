//
//  KOFileManagerConfigurationBuilder.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KOFileManagerConfiguration builder
class KOFileManagerConfigurationBuilder: KOFileManagerConfigurationBuilderProtocol {
    /// FileManager
    private var _manager                 : FileManager = FileManager.default
    //Language directory name
    private var _directoryName           : String = "Languages"
    //Search Path Directory
    private var _searchPathDirectory     : FileManager.SearchPathDirectory = .applicationSupportDirectory
    //Search path domain mask
    private var _searchPathDomainMask    : FileManager.SearchPathDomainMask = .userDomainMask
    /// Is enable debug
    private var _isEnabelDebug           : Bool = false
    init() { }
    init(configuration:KOFileManagerConfigurationProtocol) {
         _manager               = configuration.manager
         _directoryName         = configuration.directoryName
         _searchPathDirectory   = configuration.searchPathDirectory
         _searchPathDomainMask  = configuration.searchPathDomainMask
         _isEnabelDebug         = configuration.isEnabelDebug
    }
    /// Set file manager
    ///
    /// - Parameter manager: FileManager
    func setManager(manager: FileManager) {
        _manager = manager
    }
    /// Set directory name
    ///
    /// - Parameter string: String
    func setDirectoryName(string: String) {
        _directoryName = string
    }
    /// Set search path directory
    ///
    /// - Parameter directory: FileManager.SearchPathDirectory
    func setSearchPathDirectory(directory: FileManager.SearchPathDirectory) {
        _searchPathDirectory = directory
    }
    /// Set search path domain mask
    ///
    /// - Parameter domainMask: FileManager.SearchPathDomainMask
    func setSearchPathDomainMask(domainMask: FileManager.SearchPathDomainMask) {
        _searchPathDomainMask = domainMask
    }
    /// Set is enabel debug
    ///
    /// - Parameter enable: Bool
    func setIsEnabelDebug(enable: Bool) {
        _isEnabelDebug = enable
    }
    /// Create KOFileManagerConfiguration
    ///
    /// - Returns: optional KOFileManagerConfigurationProtocol
    func create() -> KOFileManagerConfigurationProtocol? {
        return KOFileManagerConfiguration(manager: _manager, directoryName: _directoryName, searchPathDirectory: _searchPathDirectory, searchPathDomainMask: _searchPathDomainMask, isEnabelDebug: _isEnabelDebug)
    }
}
