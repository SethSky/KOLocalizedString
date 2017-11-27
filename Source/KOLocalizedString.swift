//
//  KOLocalizedString.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 24.09.16.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation
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
    return  KOLocalizedCore.main.currentLanguageKey()
}
/// Set Language
///
/// - Parameter key: key language
public func KOSetLanguage(_ key:String){
    KOLocalizedCore.main.setLanguage(key)
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
