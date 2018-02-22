//
//  KODirectoryChainProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KODirectoryChain protocol
protocol KODirectoryChainProtocol {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - typealias -
    typealias SearchPathDirectory = FileManager.SearchPathDirectory
    typealias SearchPathDomainMask = FileManager.SearchPathDomainMask
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property -
    var nextChain:KODirectoryChainProtocol? { get set }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    init(configuration:KOFileManagerConfigurationProtocol)
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Functions -
    func getPath(_ name:String)->String?
    func createPath(_ directory:String,_ seachDirectory:SearchPathDirectory, _ domainMask: SearchPathDomainMask) ->String?
    func createDirectory(_ manager:FileManager,_ paths:String)->String?
}
