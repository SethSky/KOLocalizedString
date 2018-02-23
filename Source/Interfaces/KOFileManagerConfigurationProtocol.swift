//
//  KOFileManagerConfigurationProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KOFileManagerConfiguration protocol
public protocol KOFileManagerConfigurationProtocol {
    /// FileManager
    var manager                 : FileManager                       {get}
    //Language directory name
    var directoryName           : String                            {get}
    //Search Path Directory
    var searchPathDirectory     : FileManager.SearchPathDirectory   {get}
    //Search path domain mask
    var searchPathDomainMask    : FileManager.SearchPathDomainMask  {get}
    /// Is enable debug
    var isEnableDebug           : Bool                              {get}
}
