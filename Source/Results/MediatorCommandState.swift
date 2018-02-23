//
//  MediatorCommandState.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 22.02.2018.
//

import Foundation
/// Mediator command state
///
/// - loading: loading
/// - loadedBundle: loadedBundle with KOMediatorCommandProtocol
/// - error: Error
enum MediatorCommandState {
    /// Once we've succesfully loaded a Bundle
    case loadedBundle(KOMediatorCommandProtocol)
    /// Error case with Error
    case error(Error)
}

