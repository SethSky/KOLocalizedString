//
//  KOLocalizedNetwork.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 22.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//
import Foundation
import UIKit

class KOLocalizedNetwork {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Property
    //––––––––––––––––––––––––––––––––––––––––
    private var session     : URLSession!
    private var url         : String!
    private var taskArray   : Array<URLSessionTask> = []
    var isEnabelDebug       : Bool = false
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Init
    //––––––––––––––––––––––––––––––––––––––––
    /// Init with URL and defalult session
    init(_ url:String) {
        let sessionConfig = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfig)
        self.url = url
    }
    /// Init with session
    ///
    /// - Parameter session: URLSession
    init(_ session:URLSession) {
        self.session = session
    }
    /// Init with session and url
    ///
    /// - Parameters:
    ///   - session: URLSession
    ///   - url: URL
    init(_ session:URLSession, _ url:String) {
        self.session = session
        self.url = url
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Function
    //––––––––––––––––––––––––––––––––––––––––
    /// Create URL with language key
    ///
    /// - Parameter key: String
    /// - Returns: optional URL
    private func createURLWithKey(_ key:String) -> URL? {
        if let bundleID = Bundle.main.bundleIdentifier{
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                return URL(string: url + "?key=" + key + "&bundle=" + bundleID + "&ver=" + version)
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    /// Get KOLocalizedObject
    ///
    /// - Parameters:
    ///   - key: String
    ///   - success: (KOLocalizedObject)->()
    ///   - failure: (NSError)->()
    func getInfoWithKey(_ key:String, success: @escaping (Array<KOLocalizedObject>)->(), failure:@escaping (NSError)->()){
        guard self.url != nil && self.session != nil else {
            debug("KOLocalizedNetwork: " + "url or session is nil")
            return
        }
        var currentTask:URLSessionTask!
        guard let fullUrl = createURLWithKey(key) else{
            debug("KOLocalizedNetwork: " + "full URL is nil")
            return
        }
        getDictionary(key, url: fullUrl, success: { (object) in
            if currentTask != nil{ self.removeTask(currentTask) }
            if let array = object["array"] as? Array<[String:Any]>{
                var objectArray:Array<KOLocalizedObject> = []
                for dic in array{
                    objectArray.append(KOLocalizedObject(dic))
                }
                success(objectArray)
            }
        }, failure: { (error) in
            failure(error)
        }, task: { (task) in
            currentTask = task
        })
    }
    /// Get template url file from KOLocalizedObject
    ///
    /// - Parameters:
    ///   - object: KOLocalizedObject
    ///   - fileUrl: (URL)->()
    ///   - failure: (NSError)->()
    public func getTempLocalURL(_ object:KOLocalizedObject, fileUrl: @escaping (URL)->(), failure:@escaping (NSError)->()){
        if let url = URL(string: object.url){
            downloadFile(url, { (tempURL) in
                fileUrl(tempURL)
            }, { (error) in
                failure(error)
            })
        }
    }
    /// Get Dictionary
    ///
    /// - Parameters:
    ///   - key: String
    ///   - url: URL
    ///   - success: ([String:Any])->()
    ///   - failure: (NSError)->()
    ///   - task: URLSessionTask
    private func getDictionary(_ key:String , url:URL, success: @escaping ([String:Any])->(), failure:@escaping (NSError)->(), task:@escaping (URLSessionTask)->()){
        self.isNetworkActivity(true)
        let taskS = self.session.dataTask(with: url) { (data, response, error) in
            self.isNetworkActivity(false)
            let result = self.responseValidate(response, error, data: data)
            if result is [String:Any]{
                success(result as! [String : Any])
            }
            if result is NSError{
                failure(result as! NSError)
            }
        }
        task(taskS)
        taskS.resume()
        taskArray.append(taskS)
    }
    /// Download file
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - fileUrl: (URL) -> ()
    ///   - failure: (NSError)->()
    private func downloadFile(_ url: URL, _ fileUrl:@escaping (URL) -> (), _ failure:@escaping (NSError)->()) {
        self.isNetworkActivity(true)
        let task  = self.session.downloadTask(with: url) { (tempLocalUrl, response, error) in
            self.isNetworkActivity(false)
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    self.debug("KOLocalizedNetwork: " + "download Success: \(statusCode)")
                    fileUrl(tempLocalUrl)
                }
            } else {
                self.debug("KOLocalizedNetwork: " + "Failure: %@", error?.localizedDescription ?? ":")
                failure(error! as NSError)
            }
        }
        task.resume()
    }
    /// Remove task
    ///
    /// - Parameter sessionTask: URLSessionTask
    private func removeTask(_ sessionTask:URLSessionTask){
        var indexTask:Int!
        for ( index, task) in taskArray.enumerated(){
            if sessionTask == task{
                indexTask = index
                sessionTask.cancel()
            }
        }
        if indexTask != nil{
            taskArray.remove(at: indexTask)
        }
    }
    /// Response validate
    ///
    /// - Parameters:
    ///   - response: optional URLResponse
    ///   - error: optional Error
    ///   - data: optional Data
    /// - Returns: Any
    func responseValidate(_ response:URLResponse?, _ error:Error?, data:Data?) -> Any {
        if error != nil{
            debug(error ?? "KOLocalizedNetwork: not error object")
            return error!
        }
        if let httpResponse  = response as? HTTPURLResponse{
            if httpResponse.statusCode == 200{
                if let content = data {
                    do {
                        let jsonResult = try  JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)
                        return jsonResult as! [String : Any]
                    }catch let error{
                        return error
                    }
                }
            }else{
                debug("KOLocalizedNetwork: " + "Failure: %@", error?.localizedDescription ?? ":")
                if error == nil{
                    return NSError(domain: "KOLocalizedNetworkNoFound", code: 404,
                                   userInfo: ["NSLocalizedDescription":"Localization not found"])
                }
                return error! as NSError
            }
        }
        return NSError(domain: "KOLocalizedNetworkNoFound", code: 404,
                       userInfo: ["NSLocalizedDescription":"Localization not found"])
    }
    /// isNetworkActivityIndicatorVisible
    ///
    /// - Parameter active: Bool
    private func isNetworkActivity(_ visible:Bool){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }
    /// Debug print
    ///
    /// - Parameter items: Any
    private func debug(_ items:Any...){
        guard isEnabelDebug else { return }
        debugPrint(items)
    }
}
