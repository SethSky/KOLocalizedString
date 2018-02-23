//
//  KODirectoryIsExistsChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KODirectoryIsExistsChain
final class KODirectoryIsExistsChain:KODirectoryChainProtocol {
    private var _manager: FileManager
    private var _configuration:KOFileManagerConfigurationProtocol
    init(configuration:KOFileManagerConfigurationProtocol) {
        _manager = configuration.manager
        _configuration = configuration
    }
    var nextChain: KODirectoryChainProtocol?
    
    func getPath(_ name: String) -> String? {
        let path = createPath(name, _configuration.searchPathDirectory, _configuration.searchPathDomainMask)!
        if _isExistsDirectori(_manager, createPath(name, _configuration.searchPathDirectory, _configuration.searchPathDomainMask)!){
            return path
        }else{
            debugPrint("KODirectoryIsExistsChain: RETURN NIL")
            return nil
        }
    }
}
