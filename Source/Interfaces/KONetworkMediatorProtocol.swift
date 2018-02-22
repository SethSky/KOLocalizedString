//
//  KONetworkMediatorProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 17.02.2018.
//

import Foundation

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
    init(_ configuratio: KONetworkConfigurationProtocol, url:URL, isEnableDebug:Bool)
    //functions
    func setIsEnableDebug(enable:Bool)
    func setLanguageKey(key:String)
}
