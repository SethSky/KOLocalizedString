//
//  KONetworkMediatorProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 17.02.2018.
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
/// KONetworkMediator protocol
protocol KONetworkMediatorProtocol {
    //typealias
    typealias NetworkMediatorCallback = ((LocalizationNetworkState)->())
    //property
    var callback                : NetworkMediatorCallback?  { get set }
    /// Complete outside
    var completeUpdate          : ((String)->())?           { get set }
    var outSideBundle           : Bundle?                   { get } 
    //init
    init(_ configuratio: KONetworkConfigurationProtocol, url:URL, isEnabelDebug:Bool)
    //functions
    func setIsEnabelDebug(enable:Bool)
    func setLanguageKey(key:String)
}
