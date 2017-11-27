//
//  KOLocalizedObject.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation

struct KOLocalizedObject {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property
    //––––––––––––––––––––––––––––––––––––––––
    var fileName        : String!
    var url             : String!
    var latestUpdate    : String! 
    
    var isFullObject    : Bool {
        return fileName != nil && url != nil && latestUpdate != nil
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init
    //––––––––––––––––––––––––––––––––––––––––
    /// Init with dictionary
    ///
    /// - Parameter dictionary: [String:Any]
    init(_ dictionary:[String:Any]) {
        if let fileName = dictionary["filename"] as? String{
            self.fileName = fileName
        }
        if let url = dictionary["url"] as? String{
            self.url = url
        }
        if let latestUpdate = dictionary["latest_update"] as? String{
            self.latestUpdate = latestUpdate
        }
    }
}
