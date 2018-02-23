//
//  KOLocalizedObject.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation
/// KOLocalizedObject
class KOLocalizedObject: KOLocalizedObjectProtocol, Equatable, Hashable{ 
    static func ==(lhs: KOLocalizedObject, rhs: KOLocalizedObject) -> Bool {
        return lhs.fileName == rhs.fileName &&  lhs.latestUpdate == rhs.latestUpdate && lhs.url == rhs.url
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property
    var fileName        : String
    var url             : URL
    var latestUpdate    : String
    var hashValue       : Int
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init
    /// init with fileName, url and latestUpdate
    ///
    /// - Parameters:
    ///   - fileName: String
    ///   - url: URL
    ///   - latestUpdate: String
    init(fileName:String, url:URL, latestUpdate:String) {
        self.fileName = fileName
        self.url = url
        self.latestUpdate = latestUpdate
        self.hashValue = fileName.hashValue ^ url.hashValue ^ latestUpdate.hashValue
    }
}
