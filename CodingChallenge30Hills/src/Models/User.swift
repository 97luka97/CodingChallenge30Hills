//
//  User.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/14/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import Foundation

struct User {
    
    //MARK: - Properties
    
    let id: Int
    let firstName: String
    let surname: String
    let age: Int?
    let gender: String
    let friends: [Int]
}

extension User: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case surname = "surname"
        case age = "age"
        case gender = "gender"
        case friends = "friends"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        surname = try container.decode(String.self, forKey: .surname)
        age = try container.decode(Int?.self, forKey: .age)
        gender = try container.decode(String.self, forKey: .gender)
        friends = try container.decode([Int].self, forKey: .friends)
    }
}
