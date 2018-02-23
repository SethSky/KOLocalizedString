//
//  FileManagerResult.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation

enum FileManagerResult { 
    /// Once we've succesfully loaded
    case loadedFile(KOLocalizedObjectProtocol)
    /// Error case with Error
    case error(Error)
}


