//
//  HTTPURLSessionWrapper.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 17.02.2018.
//

import Foundation
/// `URLSession` wrapper that conforms to `HTTPInterface`
class HTTPURLSessionWrapper: HTTPInterface {
    /// URLSession
    var session: URLSession
    /// init with session
    ///
    /// - Parameter session: URLSession
    required init(session: URLSession) {
        self.session = session
    }
    /// Make a request as you would via `URLSession`. This will return immediately and send the response via the callback.
    ///
    /// - Parameters:
    ///   - request: URLRequest
    ///   - callback: (Data?, URLResponse?, Error?) -> ())
    func makeRequest(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let task = self.session.dataTask(with: request, completionHandler: callback)
        task.resume()
    }
    func makeDownloadRequest(request: URLRequest, callback: @escaping (URL?, URLResponse?, Error?) -> ()) {
        let task = self.session.downloadTask(with: request, completionHandler: callback)
        task.resume()
    }
}

