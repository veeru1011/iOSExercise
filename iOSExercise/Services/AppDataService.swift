//
//  AppDataService.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

protocol AppDataService {
    func fetchUsers(completion: @escaping (Result<User, Error>) -> Void)
    func fetchAlbums(userId:Int, completion: @escaping (Result<[UserAlbum], Error>) -> Void)
    func fetchPhotos(albumId:Int, completion: @escaping (Result<[UserPhoto], Error>) -> Void)
}

final class DataFetchService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}


extension DataFetchService : AppDataService {
    func fetchUsers(completion: @escaping (Result<User, Error>) -> Void) {
        let randomId = Int.random(in: 0..<9)
        let getUser = APIEndpoints.getUsers(id: randomId)
        networkService.sendRequest(endpoint: getUser) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAlbums(userId: Int, completion: @escaping (Result<[UserAlbum], Error>) -> Void) {
        let getAlbums = APIEndpoints.getAlbums(id: userId)
        networkService.sendRequest(endpoint: getAlbums) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPhotos(albumId: Int, completion: @escaping (Result<[UserPhoto], Error>) -> Void) {
        let getPhotos = APIEndpoints.getPhotos(id: albumId)
        networkService.sendRequest(endpoint: getPhotos) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
