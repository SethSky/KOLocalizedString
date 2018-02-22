//
//  LocalizationNetworkState.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 22.02.2018.
//

import Foundation
/// Localization network state
///
/// - loading: loading
/// - loadedBundle: loadedBundle with Bundle
/// - error: Error
enum LocalizationNetworkState {
    /// When loading a
    case loading
    /// Once we've succesfully loaded a Bundle
    case loadedBundle(Bundle)
    /// Error case with Error
    case error(Error)
}
