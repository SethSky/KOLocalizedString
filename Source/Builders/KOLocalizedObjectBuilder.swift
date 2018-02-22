//
//  KOLocalizedObjectBuilder.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 15.02.2018.
//

import Foundation
/// KOLocalizedObjectBuilder
public class KOLocalizedObjectBuilder: KOLocalizedObjectBuilderProtocol {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property
    private var _fileName       : String?
    private var _url            : URL?
    private var _latestUpdate   : String?
    private var _configuration  : KONetworkConfigurationProtocol = KONetworkConfigurationBuilder().create()
    private var _dictionary     : Dictionary<String,Any>?
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init
    /// Init with dictionary
    ///
    /// - Parameter dictionary: [String:Any]
    init(_ dictionary:[String:Any]) {
        _dictionary = dictionary
        _setValue()
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Func
    func setLatestUpdate(_ string: String) {
        self._latestUpdate = string
    }
    func setFileName(_ string: String) {
        self._fileName = string
    }
    func setUrl(_ string: String) {
        self._url = URL(string: string)
    }
    func setConfiguration(_ configuration:KONetworkConfigurationProtocol){
        guard _dictionary != nil else { return }
        _configuration = configuration
        _setValue()
    }
    private func _setValue(){
        guard _dictionary != nil else { return }
        if let fileName = _dictionary![_configuration.fileNameKey] as? String{
            self._fileName = fileName
        }
        if let url = _dictionary![_configuration.urlKey] as? String{
            self._url = URL(string: url)
        }
        if let latestUpdate = _dictionary![_configuration.latestUpdateKey] as? String{
            self._latestUpdate = latestUpdate
        }
    }
    func create() -> KOLocalizedObjectProtocol?{
        guard let latestUpdate = _latestUpdate, let fileName = _fileName, let url = _url else {
            return nil
        }
        return KOLocalizedObject(fileName: fileName, url: url, latestUpdate: latestUpdate)
    }
}
