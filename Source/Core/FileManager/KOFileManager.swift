//
//  KOFileManager.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 20.02.2018.
//

import Foundation
/// File manager
final class KOFileManager:KOFileManagerProtocol{
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property
    /// Callback
    var callback                    : ((FileManagerResult) -> ())?
    /// Configuration manager
    private var _configuration      : KOFileManagerConfigurationProtocol
    /// Directory path
    private var _directoryPath      : String?
    /// Directory path
    private var _tempDirectoryPath  : String?
    ///
    private var _tempDirectoryName  : String = "TempLanguage"
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init
    //Init
    init(configuration:KOFileManagerConfigurationProtocol){
        _configuration = configuration
        _setupThemp()
        _setup() 
        _debugInit(_configuration)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Setup -
    private func _setup() {
        //Create and get temp directory 
        let rootDirectoryNotExistsChain         = KODirectoryRootNotExistsChain(configuration: _configuration)
        let directoryNotExistsChain             = KODirectoryNotExistsChain(configuration: _configuration)
        let directoryIsExistsChain              = KODirectoryIsExistsChain(configuration: _configuration)
        rootDirectoryNotExistsChain.nextChain   = directoryNotExistsChain
        directoryNotExistsChain.nextChain       = directoryIsExistsChain
        if let path = rootDirectoryNotExistsChain.getPath(_configuration.directoryName){
            _directoryPath = path
        }
    }
    private func _setupThemp(){
        let rootDirectoryNotExistsChain         = KODirectoryRootNotExistsChain(configuration: _configuration)
        let directoryNotExistsChain             = KODirectoryNotExistsChain(configuration: _configuration)
        let directoryIsExistsChain              = KODirectoryIsExistsChain(configuration: _configuration)
        rootDirectoryNotExistsChain.nextChain   = directoryNotExistsChain
        directoryNotExistsChain.nextChain       = directoryIsExistsChain
        if let path = rootDirectoryNotExistsChain.getPath(_tempDirectoryName){
            _tempDirectoryPath = path
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - deinit -
    deinit {
        _debug("🔶" + #function + " File Manager")
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Public functions -
    /// Move themp file from URL with language key and KOLocalizedObjectProtocol to temp directory
    ///
    /// - Parameters:
    ///   - object: KOLocalizedObjectProtocol
    ///   - url: URL themp
    ///   - key: String
    /// - Returns: Bool
    func moveToTempLanguageFolder(_ object: KOLocalizedObjectProtocol, url: URL, key:String)->Bool {
        let rootDirectoryNotExistsChain         = KODirectoryRootNotExistsChain(configuration: _configuration)
        let directoryNotExistsChain             = KODirectoryNotExistsChain(configuration: _configuration)
        let directoryIsExistsChain              = KODirectoryIsExistsChain(configuration: _configuration)
        rootDirectoryNotExistsChain.nextChain   = directoryNotExistsChain
        directoryNotExistsChain.nextChain       = directoryIsExistsChain
        if let path = rootDirectoryNotExistsChain.getPath(_tempDirectoryName + "/" + key + ".lproj"){
            return _moveFile(url, toUrl: URL(fileURLWithPath: path + "/" + object.fileName))
        }
        return false
    }
    /// Move themp file from URL with language key and KOLocalizedObjectProtocol to temp directory
    ///
    /// - Parameters:
    ///   - object: KOLocalizedObjectProtocol
    ///   - url: URL themp
    ///   - key: String
    /// - Returns: Bool
    func moveLanguageFolderFromTemp(_ key:String)->Bool {
        let rootDirectoryNotExistsChain         = KODirectoryRootNotExistsChain(configuration: _configuration)
        let directoryNotExistsChain             = KODirectoryNotExistsChain(configuration: _configuration)
        let directoryIsExistsChain              = KODirectoryIsExistsChain(configuration: _configuration)
        rootDirectoryNotExistsChain.nextChain   = directoryNotExistsChain
        directoryNotExistsChain.nextChain       = directoryIsExistsChain 
        guard  let pathFrom = rootDirectoryNotExistsChain.getPath(_tempDirectoryName + "/" + key + ".lproj") else {return false}
        guard  let pathTO = rootDirectoryNotExistsChain.getPath(_configuration.directoryName + "/" + key + ".lproj") else {return false}
        do{
            if _configuration.manager.fileExists(atPath: pathTO){
                self.removeDirectory(key)
                try _configuration.manager.moveItem(atPath: pathFrom, toPath: pathTO)
                return true
            }else{
                try _configuration.manager.moveItem(atPath: pathFrom, toPath: pathTO)
                return true
            }
        }catch let error{
            callback?(FileManagerResult.error(error))
            return false
        }
    }
    /// Remove directory with key
    ///
    /// - Parameter key: String
    func removeDirectory(_ key:String){
        if let path = _directoryPath{
            let lprojPath = path + "/" + key + ".lproj"
            if _configuration.manager.fileExists(atPath: lprojPath){
                try! _configuration.manager.removeItem(atPath: lprojPath)
                _debug("🔺 File Manager: remove directory with key [ \(key) ] successful")
            }
        }
    }
    /// If directory empty, remove his
    ///
    /// - Parameter key: String
    func getBundle(_ key:String)->Bundle?{
        if let path = _directoryPath{
            let lprojPath = path + "/" + key + ".lproj"
            if let bundle = Bundle(path:lprojPath){
                if !self._isEmptyDirectory(lprojPath){
                    _debug("🔺 File Manager: get bundle with key [ \(key) ] successful")
                    return bundle
                }
            }
        }
        _debug("🔺 File Manager: get bundle with key [ \(key) ] failure")
        return nil
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Private functions -
    /// Is empty directory with path
    ///
    /// - Parameter path: String
    /// - Returns: Bool
    private func _isEmptyDirectory(_ path:String)->Bool{
        if let fileArray = try? _configuration.manager.contentsOfDirectory(atPath:path){
            return fileArray.count == 0
        }
        return true
    }
    /// Move file from URL to URL
    ///
    /// - Parameters:
    ///   - fromUrl: URL
    ///   - toUrl: URL
    /// - Returns: Bool
    private func _moveFile(_ fromUrl:URL, toUrl:URL)->Bool{
        do{
            if _configuration.manager.fileExists(atPath: toUrl.path){
                _ = try _configuration.manager.replaceItemAt(toUrl, withItemAt: fromUrl)
                return true
            }else{
                try _configuration.manager.moveItem(at: fromUrl, to: toUrl)
                return true
            }
        }catch let error{
            callback?(FileManagerResult.error(error))
            let nsError = error as NSError
            guard  nsError.code != 516 else{
                return false
            }
            return _moveFile(fromUrl, toUrl: toUrl)
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - debug -
    /// Debug init
    ///
    /// - Parameters:
    ///   - url: url
    ///   - configuration: configuration
    private func _debugInit(_ configuration: KOFileManagerConfigurationProtocol){
        _debug("----------------------------------------------------------")
        _debug("🔶 init File manager with Configuration:")
        _debug("----------------------------------------------------------")
        _debug("🔺 FileManager: \(configuration.manager.description)")
        _debug("🔺 Language directory name: \(configuration.directoryName)")
        _debug("🔺 Search Path Directory: \(configuration.searchPathDirectory.rawValue)")
        _debug("🔺 Search path domain mask: \(configuration.searchPathDomainMask.rawValue)") 
        _debug("----------------------------------------------------------")
    }
    /// Debug print
    ///
    /// - Parameter items: Any
    private func _debug(_ items:Any...){
        guard _configuration.isEnableDebug else { return }
        debugPrint(items)
    }
}
