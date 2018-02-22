//
//  HTTPInterface.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 17.02.2018.
//

import Foundation
/// A protocol for making network requests
protocol HTTPInterface {
    var session:URLSession { get }
    init(session:URLSession)
    /// Make a network request asynchronously
    ///
    /// - Parameters:
    ///   - request: URLRequest
    ///   - callback: (Data?, URLResponse?, Error?) -> ())
    func makeRequest(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> ())
    func makeDownloadRequest(request: URLRequest, callback: @escaping (URL?, URLResponse?, Error?) -> ())
}
