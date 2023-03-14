//
//  NetworkService.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

public enum AppError: Error {
    case unknown(code: String)
    case nilData
    case badRequest
    case notFound
    case generic(Error)
    case noConnection
    case cancelled
    case urlGeneration
    case noLocalDataFound
    case jsonDecodeError
    
    init(errorCode: Int, error : Error? = nil ) {
        switch errorCode {
        case 400:
            self = .badRequest
        case 404:
            self = .notFound
        default:
            if let error = error {
                self = .generic(error)
            }
            else {
                self = .unknown(code:"\(errorCode)")
            }
        }
    }
}

public protocol NetworkService {
    typealias CompletionHandler<T> = (Result<T, AppError>) -> Void
    func sendRequest<T: Decodable,E: ResponseRequestable>(endpoint: E, completion: @escaping CompletionHandler<T>) where T == E.Response
}

public final class NetworkFetchService {
    
    private let sessionManager: NetworkSessionManager
    
    public init(sessionManager: NetworkSessionManager = SessionManager()) {
        self.sessionManager = sessionManager
    }
    
    private func request<T: Decodable>(request: URLRequest,responseDTO: T.Type, completion: @escaping CompletionHandler<T>) {
        
        sessionManager.request(request) { data, response, requestError in
            
            if let requestError = requestError {
                var error: AppError
                if let response = response as? HTTPURLResponse {
                    error = AppError(errorCode: response.statusCode)
                } else {
                    error = self.resolve(error: requestError)
                }
                completion(.failure(error))
            } else {
                if let rawData = data {
                    guard let decodedResponse = try? JSONDecoder().decode(responseDTO, from: rawData) else {
                        completion(.failure(AppError.jsonDecodeError))
                        return
                    }
                    completion(.success(decodedResponse))
                }
                else {
                    completion(.failure(AppError.nilData))
                }
            }
        }
    }
    
    private func resolve(error: Error) -> AppError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .noConnection
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}


extension NetworkFetchService: NetworkService {
        
    public func sendRequest<T, E>(endpoint: E, completion: @escaping CompletionHandler<T>) where T : Decodable, T == E.Response, E : ResponseRequestable {
        do {
            let urlRequest = try endpoint.urlRequest()
            request(request: urlRequest, responseDTO: T.self, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
        }
    }
}
