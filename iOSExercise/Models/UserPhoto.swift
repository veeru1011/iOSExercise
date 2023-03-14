//
//  UserPhoto.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

struct UserPhoto : Codable, Identifiable {
    let albumId: Int?
    let id:Int?
    let title:String?
    let url:String?
    let thumbnailUrl:String?
}
