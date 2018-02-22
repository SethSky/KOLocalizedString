//
//  KOLocalizedExtensions.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 24.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation

public extension Notification.Name{
    static let KODidChangeLanguage      = Notification.Name("kKODidChangeLanguage")
    static let KODidUpdateBundle        = Notification.Name("kKODidUpdateBundle")
    static let KODidUpdateDictionary    = Notification.Name("kKODidUpdateDictionary")
}
