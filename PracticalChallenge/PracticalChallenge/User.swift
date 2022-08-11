//
//  User.swift
//  PracticalChallenge
//
//  Created by Deane Karsten on 11/08/22.
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
    let name: UserNames
    let dob: UserDOB
    let picture: UserPictureURL
    let email: String
    let cell: String
}

struct UserNames: Decodable {
    let title: String
    let first: String
    let last: String
}

struct UserDOB: Decodable {
    let date: String
    let age: Int
}

struct UserPictureURL: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
