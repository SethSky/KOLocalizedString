//
//  KOLocalizedExtensions.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 24.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation
/// Notification name did change language
public let KODidChangeLanguage      = Notification.Name("kKODidChangeLanguage")
/// Notification name did update bundle
public let KODidUpdateBundle        = Notification.Name("kKODidUpdateBundle")
/// Notification name did update dictionary
public let KODidUpdateDictionary    = Notification.Name("kKODidUpdateDictionary")
//
extension Notification.Name{
    static let KODidChangeLanguage      = Notification.Name("kKODidChangeLanguage")
    static let KODidUpdateBundle        = Notification.Name("kKODidUpdateBundle")
    static let KODidUpdateDictionary    = Notification.Name("kKODidUpdateDictionary")
}
