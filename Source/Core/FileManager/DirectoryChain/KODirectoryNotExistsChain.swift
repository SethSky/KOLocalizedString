//
//  KODirectoryNotExistsChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
///KODirectoryNotExistsChain
final class KODirectoryNotExistsChain:KODirectoryChainProtocol {
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
        if _isExistsDirectori(_manager, createPath(name, _configuration.searchPathDirectory, _configuration.searchPathDomainMask)!){
            return nextChain?.getPath(name)
        }else{
            if createDirectory(_manager, createPath(name, _configuration.searchPathDirectory, _configuration.searchPathDomainMask)!) != nil{
                return nextChain?.getPath(name)
            }
        }
        debugPrint("KODirectoryNotExistsChain: RETURN NIL")
        return nil
    }
}
