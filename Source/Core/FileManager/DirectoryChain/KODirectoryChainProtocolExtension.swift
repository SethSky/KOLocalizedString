//
//  KODirectoryChainProtocolExtension.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
///KODirectoryChainProtocol Extension
extension KODirectoryChainProtocol{
    /// Create Path for outside localized didectory
    ///
    /// - Parameters:
    ///   - userDirectory: String
    ///   - directory: FileManager.SearchPathDirectory
    ///   - domainMask: FileManager.SearchPathDomainMask
    /// - Returns: String or nil
    func createPath(_ directory:String,_ seachDirectory:SearchPathDirectory, _ domainMask: SearchPathDomainMask) ->String?{
        let paths = NSSearchPathForDirectoriesInDomains(seachDirectory, domainMask, true)
        if let documentsDirectory: String = paths.first{
            let path = documentsDirectory + "/" + directory
            return path
        }else{
            return nil
        }
    }
    /// Create directory
    ///
    /// - Parameters:
    ///   - paths: paths
    ///   - success: (String)->()
    ///   - failure: (NSError)->()
    func createDirectory(_ manager:FileManager,_ paths:String)->String?{
        do {
            try manager.createDirectory(atPath: paths, withIntermediateDirectories: false, attributes: nil)
            return paths
        } catch{
            debugPrint(error)
            return nil
        }
    }
    //Chack is exists directory
    func _isExistsDirectori(_ manager:FileManager, _ path:String)->Bool{
        return manager.fileExists(atPath: path)
    }
}
