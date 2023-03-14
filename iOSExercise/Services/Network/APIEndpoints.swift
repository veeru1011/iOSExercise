//
//  APIEndpoints.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

struct APIEndpoints {
    
    static func getAlbums(id:Int) -> Endpoint<[UserAlbum]> {
        return Endpoint(path: "users/\(id)/albums")
    }
    
    static func getUsers(id:Int) -> Endpoint<User> {
        return Endpoint(path: "users/\(id)")
    }
    
    static func getPhotos(id:Int) -> Endpoint<[UserPhoto]> {
        return Endpoint(path: "photos")
    }
}
