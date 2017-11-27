//
//  KOLocalizedFileManager.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import Foundation
import UIKit

internal class KOLocalizedFileManager {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property
    //––––––––––––––––––––––––––––––––––––––––
    /// FileManager 
    private let manager             : FileManager = FileManager.default
    //Language directory name
    private var directoryName       : String = "Languages"
    //Search Path Directory
    private var searchPathDirectory : FileManager.SearchPathDirectory = .applicationSupportDirectory
    //Search path domain mask
    private var searchPathDomainMask: FileManager.SearchPathDomainMask = .userDomainMask
    /// Path directory
    var pathDirectory               : String!
    // Is enable debug
    var isEnabelDebug               : Bool = true
    // Keys UserDefaults
    private var keyArray            : Array<String> = []
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init
    //––––––––––––––––––––––––––––––––––––––––
    //Init
    init(){
       setup() 
    }
    /// Init with isEnabelDebug property
    ///
    /// - Parameter isEnabelDebug: Bool
    init(_ isEnabelDebug:Bool) {
        self.isEnabelDebug = isEnabelDebug
        setup()
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Setup Directory/Path
    //––––––––––––––––––––––––––––––––––––––––
    /// Setup
    private func setup(){
        pathLanguage { (path) in
            self.pathDirectory = path
        }
    }
    //Create Path
    private func createPath()->String?{
        let path = createPath(directoryName, searchPathDirectory, searchPathDomainMask)
        return path
    }
    //Chack is exists directory
    private func isExistsDirectori(_ path:String)->Bool{
        return manager.fileExists(atPath: path)
    }
    //If exists Language dir return dir else create dir after return path
    private func pathLanguage(_ success:@escaping(String)->()){
        if let path = createPath(){
            if isExistsDirectori(createPath("", searchPathDirectory, searchPathDomainMask)!){
                if isExistsDirectori(path){
                    success(path)
                }else{
                    debug("KOLocalizedFileManager: " + directoryName + " does not exist")
                    createDirectory(path, success: { (locDir) in
                        success(path)
                    }, failure: { (error) in
                        debug("KOLocalizedFileManager: " + error.localizedDescription)
                    })
                }
            }else{
                 debug("KOLocalizedFileManager: Aplication Support does not exist")
                 createDirectory(createPath("", searchPathDirectory, searchPathDomainMask)!, success: { (locDir) in
                    createDirectory(path, success: { (locDir) in
                        success(path)
                    }, failure: { (error) in
                        debug("KOLocalizedFileManager: " + error.localizedDescription)
                    })
                }, failure: { (error) in
                    debug(error.localizedDescription)
                })
            }
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Create Directory/Path
    //––––––––––––––––––––––––––––––––––––––––
    /// Create Path for outside localized didectory
    ///
    /// - Parameters:
    ///   - userDirectory: String
    ///   - directory: FileManager.SearchPathDirectory
    ///   - domainMask: FileManager.SearchPathDomainMask
    /// - Returns: String or nil
    private func createPath(_ directory:String, _ seachDirectory:FileManager.SearchPathDirectory, _ domainMask: FileManager.SearchPathDomainMask) ->String?{
        debug("KOLocalizedFileManager: createPath localizeDirectory: " + directory)
        let paths = NSSearchPathForDirectoriesInDomains(seachDirectory, domainMask, true)
        if let documentsDirectory: String = paths.first{
            let path = documentsDirectory + "/" + directory
            return path
        }else{
            return nil
        }
    }
    /// Create directory
    ///
    /// - Parameters:
    ///   - paths: paths
    ///   - success: (String)->()
    ///   - failure: (NSError)->()
    internal func createDirectory(_ paths:String, success:(String)->(), failure:(NSError)->()){
        do {
            try manager.createDirectory(atPath: paths, withIntermediateDirectories: false, attributes: nil)
            debug("KOLocalizedFileManager: createDirectory: " + paths)
            success(paths)
        } catch let error as NSError {
            failure(error)
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Save Files
    //––––––––––––––––––––––––––––––––––––––––
    /// Save file to directory lproj with KOLocalizedObject, to url and language key
    ///
    /// - Parameters:
    ///   - object: KOLocalizedObject
    ///   - url: URL
    ///   - key: String
    internal func saveFile(_ object:KOLocalizedObject, url:URL, _ key:String){
        debug("KOLocalizedFileManager: saveFile:" + object.fileName + " to: " + key + ".lproj")
        let lprojPath = pathDirectory + "/" + key + ".lproj"
        if self.isExistsDirectori(lprojPath){
                if isNeedUpdateDataWithObject(object, key: key){
                    _ = moveFile(url, toUrl: URL(fileURLWithPath: lprojPath + "/" + object.fileName))
                }
        }else{
            self.createDirectory(lprojPath, success: { (dir) in
                self.saveFile(object, url: url, key)
            }, failure: { (error) in
                if error.code == 4{
                    self.pathLanguage { (path) in
                        self.saveFile(object, url: url, key)
                    }
                }
                debug(error.localizedDescription)
            })
        }
    }
    /// Move file from url to url, if file exists replace it file
    ///
    /// - Parameters:
    ///   - fromUrl: URL
    ///   - toUrl: URL
    /// - Returns: Bool
    private func moveFile(_ fromUrl:URL, toUrl:URL)->Bool{
        do{
            debug(toUrl.path)
            if manager.fileExists(atPath: toUrl.path){
                _ = try  manager.replaceItemAt(toUrl, withItemAt: fromUrl)
                debug("KOLocalizedFileManager: replace file:" + toUrl.absoluteString)
                return true
            }else{
                try manager.moveItem(at: fromUrl, to: toUrl)
                debug("KOLocalizedFileManager: move file:" + toUrl.absoluteString)
                return true
            }
        }catch let error{
           debug(error)
           return moveFile(fromUrl, toUrl: toUrl)
        }
    }
    /// Remove directory with key
    ///
    /// - Parameter key: String
    func removeDirectory(_ key:String?){
        guard key != nil else {
            try! manager.removeItem(atPath: pathDirectory)
            return
        }
        let lprojPath = pathDirectory + "/" + key! + ".lproj"
        debug("KOLocalizedFileManager: Remove directory:" + lprojPath)
        try! manager.removeItem(atPath: lprojPath)
    }
    /// Save date update fiele
    ///
    /// - Parameters:
    ///   - key: String
    ///   - date: String
    private func saveDateUpdateFiele(_ key:String, date:String){
        debug("KOLocalizedFileManager: Save date last update fiele")
        UserDefaults.standard.setValue(date, forKey: key)
        for obj in keyArray{
            if key == obj{
                return
            }
        }
        keyArray.append(key)
    }
    /// Is empty directory with path
    ///
    /// - Parameter path: String
    /// - Returns: Bool
    private func isEmptyDirectory(_ path:String)->Bool{
        debug("KOLocalizedFileManager: isEmptyDirectory")
        if let fileArray = try? manager.contentsOfDirectory(atPath:path){
            return fileArray.count == 0
        }
        return true
    }
    /// is need Update data with Object and key
    ///
    /// - Parameters:
    ///   - object: KOLocalizedObject
    ///   - key: String
    /// - Returns: Bool
    private func isNeedUpdateDataWithObject(_ object:KOLocalizedObject, key:String) -> Bool {
        debug("KOLocalizedFileManager: is need update file with object")
        guard let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else {
            return false
        }
        if object.isFullObject{
            let fileKey = "k" + object.fileName + key + version
            if let date = UserDefaults.standard.value(forKey: fileKey) as? String{
                if date != object.latestUpdate{
                    saveDateUpdateFiele(fileKey, date:object.latestUpdate)
                    return date != object.latestUpdate
                }else{
                    return false
                }
            }else{
                saveDateUpdateFiele(fileKey, date:object.latestUpdate)
                return true
            }
        }
        return false
    }
    /// If directory empty, remove his
    ///
    /// - Parameter key: String
    func checkEmptyDirectory(_ key:String){
        debug("KOLocalizedFileManager: Check empty directory " + key + ".lproj")
        let lprojPath = pathDirectory + "/" + key + ".lproj"
        if isEmptyDirectory(lprojPath){
            removeDirectory(key)
        }
    }
    /// Get array with keys to UserDefaults
    ///
    /// - Returns:  Array<String> 
    func getKeysArray() -> Array<String> {
        return keyArray
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - get Bundle
    //––––––––––––––––––––––––––––––––––––––––
    /// Get outside Bundle with key
    ///
    /// - Parameter key: key
    /// - Returns: Bundle or nil
    internal func getOutsideBundleWithKey(_ key:String, countFiles:Int?)->Bundle?{
        debug("KOLocalizedFileManager: get outside Bundle with key")
        guard pathDirectory != nil else {
            return nil
        }
        let lprojPath =  pathDirectory + "/" + key + "." + "lproj"
        if let fileArray = try? manager.contentsOfDirectory(atPath:lprojPath){
            guard countFiles == nil || fileArray.count == countFiles else { return nil }
            if let bundle = Bundle(path:lprojPath){
                if self.isEmptyDirectory(pathDirectory + "/" + key + "." + "lproj"){
                    return nil
                }else{
                    return bundle
                }
            }
        }
        return nil
    }
    
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Debug
    //––––––––––––––––––––––––––––––––––––––––
    /// Debug print
    ///
    /// - Parameter items: Any
    private func debug(_ items:Any...){
        guard isEnabelDebug else { return }
        debugPrint(items)
    }
}
