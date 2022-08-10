//
//  User.swift
//  PracticalChallenge
//
//  Created by Deane Karsten on 10/08/22.
//

import Foundation

struct UserResponse: Decodable {
    let results: [User]?
    let info: ResponseInfo?
}

struct ResponseInfo: Decodable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

struct User: Decodable {
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case gender
    }
}
