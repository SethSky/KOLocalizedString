//
//  HTTPResults.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 21.02.2018.
//

import Foundation
/// HTTP Result
///
/// - success: success with [String : Any]
/// - error: error with Error
enum HTTPResult {
    case success([[String : Any]])
    case error(Error)
}
/// Language list result
///
/// - success: KOLocalizedObjectProtocol array
/// - error: error with Error
enum LanguageListResult {
    case success([KOLocalizedObjectProtocol])
    case error(Error)
}
/// Download file result
///
/// - success: URL
/// - error: error with Error
enum DownloadResult{
    case success(URL)
    case error(Error)
}
