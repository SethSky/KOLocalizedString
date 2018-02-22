//
//  KODirectoryRootNotExistsChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KODirectoryRootNotExistsChain
final class KODirectoryRootNotExistsChain:KODirectoryChainProtocol { 
    private var _manager: FileManager
    private var _configuration:KOFileManagerConfigurationProtocol
    var nextChain: KODirectoryChainProtocol?
    init(configuration:KOFileManagerConfigurationProtocol) {
        _manager = configuration.manager
        _configuration = configuration
    }
    /// getPath
    ///
    /// - Parameter name: String
    /// - Returns: optional String
    func getPath(_ name: String) -> String? {
        if _isExistsDirectori(_manager, createPath("", _configuration.searchPathDirectory, _configuration.searchPathDomainMask)!){
            return nextChain?.getPath(name)
        }else{
            if let _ = createDirectory(_manager, createPath("", _configuration.searchPathDirectory, _configuration.searchPathDomainMask)!){
                return nextChain?.getPath(name)
            }
        }
        debugPrint("KODirectoryRootNotExistsChain: RETURN NIL")
        return nil
    }
}
