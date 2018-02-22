//
//  KOLocalizedNetwork.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//
import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
#endif
/// KOLocalizedNetwork
class KOLocalizedNetwork:KOLocalizedNetworkProtocol {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property -
    /// is enabel debug
    private var _isEnableDebug  : Bool
    // HTTP interface
    private let _httpInterface  : HTTPInterface
    private let _configuration  : KONetworkConfigurationProtocol
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init -
    /// init with URLSession, KONetworkConfigurationProtocol end isEnableDebug
    ///
    /// - Parameters:
    ///   - session: URLSession
    ///   - isEnableDebug: Bool
    ///   - configuration: KONetworkConfigurationProtocol
    required init(isEnableDebug:Bool, configuration:KONetworkConfigurationProtocol) {
        _httpInterface = HTTPURLSessionWrapper(session: configuration.session)
        _isEnableDebug = isEnableDebug
        _configuration = configuration
        _debugInit(configuration)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - deinit -
    deinit {
        _debug("----------------------------------------------------------")
        _debug("🔶" + #function + " Localized network")
        _debug("----------------------------------------------------------")
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Networking  -
    /// get city list with  location coordinate
    ///
    /// - Parameters:
    ///   - location: CLLocationCoordinate2D
    ///   - callback: (([CityProtocol]) -> ()
    func getLanguageList(_ url: URL, key:String, callback: @escaping (LanguageListResult)->()) { 
        guard let request = _getURLRequest(url, key, _configuration) else { return }
        _isNetworkActivity(true)
        _httpInterface.makeRequest(request: request) { (data, response, error) in
            self._isNetworkActivity(false)
            switch self.responseValidate(response, error, data: data){
            case .success(let array):
                let objArray = self._createObjectArray(array)
                guard objArray.count != 0 else { return }
                callback(LanguageListResult.success(objArray))
            case .error(let error):
                callback(LanguageListResult.error(error))
            }
        }
    }
    /// Download file with url and return file url
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - callback: (DownloadResult)->()
    func getFilePath(_ url: URL, callback: @escaping (DownloadResult)->()){
        _httpInterface.makeDownloadRequest(request: URLRequest(url: url)) { (tempLocalUrl, response, error) in
            guard error == nil else{
                callback(DownloadResult.error(error!))
                return
            }
            guard  let tempLocalUrl = tempLocalUrl, error == nil else{
                callback(DownloadResult.error(NSError(domain: KOErrorDomine, code: -1006, userInfo: ["NSLocalizedDescription":"Downloading file with URL:\(url) is failure"])))
                return
            }
            callback(DownloadResult.success(tempLocalUrl))
        }
    }
    /// Get URLRequest with url and language key. Return optional URLRequest
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - languageKey: String
    /// - Returns: optional URLRequest
    private func _getURLRequest(_ url:URL,_ languageKey:String,_ configuration:KONetworkConfigurationProtocol) -> URLRequest? {
        if let bundleID = Bundle.main.bundleIdentifier{
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                let keyItem     = URLQueryItem(name: configuration.requestLangKey!, value: languageKey)
                let bundleItem  = URLQueryItem(name: configuration.requestBundlekey!, value: bundleID)
                let verItem     = URLQueryItem(name: configuration.requestVersionkey!, value: version)
                
                var urlComps = URLComponents(url:url, resolvingAgainstBaseURL: false)
                urlComps?.queryItems = [keyItem,bundleItem,verItem]
                guard let fullUrl = urlComps?.url else { return nil }
                return URLRequest(url:fullUrl)
            }
        }
        return nil
    }
    /// Response validate
    ///
    /// - Parameters:
    ///   - response: optional URLResponse
    ///   - error: optional Error
    ///   - data: optional Data
    /// - Returns: Any
    func responseValidate(_ response:URLResponse?, _ error:Error?, data:Data?) -> HTTPResult{
        let responseErrorChain          = KOResponseErrorChain()
        let responseValidateChain       = KOResponseValidateChain()
        let responseExtractionDataChain = KOResponseExtractionDataChain()
        let responseCreateResultChain   = KOResponseCreateResultChain(configuration: _configuration)
        responseErrorChain.nextChain            = responseValidateChain
        responseValidateChain.nextChain         = responseExtractionDataChain
        responseExtractionDataChain.nextChain   = responseCreateResultChain
        return responseErrorChain.getResult(response, error, data)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Help function -
    /// Create KOLocalizedObjectProtocol array
    ///
    /// - Parameter array: Dictionary array
    /// - Returns: KOLocalizedObjectProtocol array
    private func _createObjectArray(_ array:[[String:Any]]) -> [KOLocalizedObjectProtocol] {
        let returnArray:[KOLocalizedObjectProtocol] = array.flatMap{
            let builder = KOLocalizedObjectBuilder($0)
            builder.setConfiguration(self._configuration)
            return builder.create()
        }
        return returnArray
    }
    //––––––––––––––––––––––––––––––––––––––––
    /// Debug init
    ///
    /// - Parameters:
    ///   - url: url
    ///   - configuration: configuration
    private func _debugInit(_ configuration: KONetworkConfigurationProtocol){
        _debug("----------------------------------------------------------")
        _debug("◻️ init Localized network with Configuration:")
        _debug("----------------------------------------------------------") 
        _debug("▫️ fileNameKey         :\(configuration.fileNameKey)")
        _debug("▫️ urlKey              :\(configuration.urlKey)")
        _debug("▫️ latestUpdateKey     :\(configuration.latestUpdateKey)")
        _debug("▫️ requestLangKey      :\(configuration.requestLangKey ?? "")")
        _debug("▫️ requestBundlekey    :\(configuration.requestBundlekey ?? "")")
        _debug("▫️ requestVersionkey   :\(configuration.requestVersionkey ?? "")")
        _debug("----------------------------------------------------------")
    }
    /// Debug print
    ///
    /// - Parameter items: Any
    private func _debug(_ items:Any...){
        guard _isEnableDebug else { return }
        debugPrint(items)
    }
    /// isNetworkActivityIndicatorVisible
    ///
    /// - Parameter active: Bool
    private func _isNetworkActivity(_ visible:Bool){
        #if os(iOS)
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = visible
            }
        #elseif os(OSX)
        #endif
    }
}
