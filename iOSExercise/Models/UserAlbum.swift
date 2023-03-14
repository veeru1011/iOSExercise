//
//  UserAlbum.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

struct UserAlbum : Codable, Identifiable {
    let id:Int
    let userId: Int?
    let title:String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try? container.decodeIfPresent(Int.self, forKey: .userId)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try? container.decodeIfPresent(String.self, forKey: .title)
    }
}
