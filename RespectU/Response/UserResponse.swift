//
//  User.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct UserResponse: Codable {
    struct User: Codable {
        let uid: String
        let nickname: String
        let identifier: String
        let password: String
    }
    let users: [User]
}
