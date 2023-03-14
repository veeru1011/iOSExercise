//
//  User.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

struct User : Codable {
    let id: Int?
    let name:String?
    let username:String?
    let email:String?
    let address:Address?
    let phone:String?
    let website:String?
    let company:Company?
}

struct Company : Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Address : Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
}
