//
//  NetworkSessionManager.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

import Foundation

public protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler)
}

// MARK: - SessionManager

public final class SessionManager: NetworkSessionManager {
    public init() {}
    public func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
