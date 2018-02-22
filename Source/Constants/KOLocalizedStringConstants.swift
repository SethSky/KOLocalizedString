//
//  KOLocalizedStringConstants.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 21.02.2018.
//
//__FILE__ -> #file
//__LINE__ -> #line
//__COLUMN__ -> #column
//__FUNCTION__ -> #function (Added during review)
//__DSO_HANDLE__ -> #dsohandle
import Foundation
//––––––––––––––––––––––––––––––––––––––––
//MARK: - Notification constants -
/// Notification name did change language
public let KODidChangeLanguage      = Notification.Name("kKODidChangeLanguage")
/// Notification name did update bundle
public let KODidUpdateBundle        = Notification.Name("kKODidUpdateBundle")
/// Notification name did update dictionary
public let KODidUpdateDictionary    = Notification.Name("kKODidUpdateDictionary")
//––––––––––––––––––––––––––––––––––––––––
//MARK: - Network constants -
let KOErrorDomine = "KOLocalizedNetwork.domine"
