//
//  EndPoint.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

public protocol URLRequestable {
    var path: String { get }
    func urlRequest() throws -> URLRequest
}

public class Endpoint<R>: ResponseRequestable {
    public typealias Response = R
    public let path: String
    
    lazy var appConfiguration = AppConfiguration()
    
    init(path: String) {
        self.path = path
    }
    
    public func urlRequest() throws -> URLRequest {
        let apiBaseURL = appConfiguration.apiBaseURL
        var baseURL = URL(string: apiBaseURL)!
        if let pathUrl = URL(string: self.path), pathUrl.host != nil {
            baseURL = pathUrl
        }
        else {
            baseURL.appendPathComponent(self.path)
        }
        var components = URLComponents(string: baseURL.absoluteString)
        components?.queryItems = [URLQueryItem]()
        let request = URLRequest(url: (components?.url)!)
        return request
    }
}

public protocol ResponseRequestable: URLRequestable {
    associatedtype Response
}
