//
//  User.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

/// The repsonse object about user.
struct UserResponse: Codable {
  
  /// The user data in the user response object.
  struct User: Codable {
    
    /// The uid of the user.
    let uid: String
    
    /// The nickname of the user.
    let nickname: String
    
    /// The identifier of the user.
    let identifier: String
    
    /// The password of the user.
    let password: String
  }
  
  /// The users.
  let users: [User]
}
