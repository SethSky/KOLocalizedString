//
//  KOOutSideBundleChain.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// OutSide bundle chain of responsibility with language key
final class KOOutSideBundleChain: KOBundleChainProtocol{
    private var _updateOutside  : Bool
    private var _url            : URL?
    private var _mediator       : KONetworkMediatorProtocol?
    var nextChain               : KOBundleChainProtocol?
    /// Get Bundle
    ///
    /// - Parameter forKey: String
    /// - Returns: optional Bundle
    func getBundle(_ forKey: String) -> Bundle? {
        guard _mediator != nil && _mediator?.outSideBundle != nil && _updateOutside else {
            return nextChain?.getBundle(forKey)
        }
        return _mediator?.outSideBundle
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    /// Init with updateOutside, url, fileManager
    ///
    /// - Parameters:
    ///   - updateOutside: Bool default false
    ///   - url: optional URL
    ///   - fileManager: optional KOLocalizedFileManager
    init(_ updateOutside:Bool = false, mediator:KONetworkMediatorProtocol?) {
        self._updateOutside = updateOutside
        self._mediator = mediator
    }
}




