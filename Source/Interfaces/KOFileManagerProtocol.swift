//
//  KOFileManagerProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 18.02.2018.
//

import Foundation
/// KOFileManager protocol
protocol KOFileManagerProtocol {
    var callback:((FileManagerResult)->())? { get set }
    init(configuration:KOFileManagerConfigurationProtocol) 
    func getBundle(_ key:String)->Bundle?
    func removeDirectory(_ key:String)
    //
    func moveToTempLanguageFolder(_ object: KOLocalizedObjectProtocol, url: URL, key:String)->Bool
    func moveLanguageFolderFromTemp(_ key:String)->Bool
}
