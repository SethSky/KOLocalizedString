//
//  KOLocalizedString.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 24.09.16.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
#endif
//––––––––––––––––––––––––––––––––––––––––
//MARK: - Interface -
//––––––––––––––––––––––––––––––––––––––––
/// Key for creting error description
public let KOLocalizedDescriptionKey = "KOLocalizedDescription"
/// Returns a localized string, using the main bundle if one is not specified.
public func KOLocalizedString(_ key: String, comment: String) -> String{
    return KOLocalizedCore.main.localizedStringForKey(key)
}
/// Returns a localized string.
public func KOLocalizedString(_ key: String) -> String{
    return KOLocalizedCore.main.localizedStringForKey(key)
}
/// Current language key
///
/// - Returns: return current locale
public func KOCurrentLanguageKey()->String{
    return KOLocalizedCore.main.currentLanguageKey()
}
/// Set Language
///
/// - Parameter key: key language
public func KOSetLanguage(_ key:String){
    KOLocalizedCore.main.setLanguage(key)
}
#if os(iOS)
    /// Get localized image with name
    ///
    /// - Parameter named: String
    /// - Returns: UIImage. if not found file return empty UIImage()
    public func KOLocalizedImage(named:String)->UIImage{
        guard let bundle = KOLocalizedCore.main.currentBundle else { return UIImage() }
        return UIImage(named: named, in: bundle, compatibleWith: nil) ?? UIImage()
    }
    /// Get localized image with name and type file
    ///
    /// - Parameters:
    ///   - forResource: String
    ///   - ofType: String
    /// - Returns:  UIImage. if not found file return empty UIImage()
    public func KOLocalizedImage(forResource:String,  ofType:String)->UIImage{
        guard let bundle = KOLocalizedCore.main.currentBundle else { return UIImage() }
        guard let path = bundle.path(forResource: forResource, ofType: ofType) else { return UIImage() }
        return UIImage(contentsOfFile: path) ?? UIImage()
    }
#elseif os(OSX)
#endif
///  Get path file
///
/// - Parameters:
///   - forResource: String
///   - ofType: String
/// - Returns: String
public func KOLocalizedFilePath(forResource:String,  ofType:String)->String?{
    guard let bundle = KOLocalizedCore.main.currentBundle else { return nil }
    return bundle.path(forResource: forResource, ofType: ofType, inDirectory: nil)
}
/// Get language keys array
///
/// - Returns: Array<String>
public func KOGetLanguageArray()->Array<String>{
    var array:Array<String> = []
    for key in Bundle.main.localizations{
        if key != "Base"{
            array.append(key)
        }
    }
    return array
}