//
//  API+User.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

import SwiftKeychainWrapper

// MARK: APIService + User

extension APIService {
  
  func requestSignIn(id: String, password: String, completion: @escaping (Int?, Error?) -> Void) {
    let parameters = ["id": id, "password": password]
    networkManager
      .post("\(baseURL)/users/signin", parameters: parameters) { _, statusCode, error in
        completion(statusCode, error)
    }
  }
  
  func requestSignUp(id: String,
                     password: String,
                     nickname: String,
                     completion: @escaping (Int?, Error?) -> Void) {
    let parameters = ["id": id, "password": password, "nickname": nickname]
    networkManager
      .post("\(baseURL)/users/signup", parameters: parameters) { _, statusCode, error in
        completion(statusCode, error)
    }
  }
  
  func requestVersions(completion: @escaping (VersionResponse?, Error?) -> Void) {
    networkManager.get("\(baseURL)/version") { data, error in
      let (decoded, error) = self.decode(to: VersionResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
  
  func requestNickname(completion: @escaping (NicknameResponse?, Error?) -> Void) {
    let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
    if id.isEmpty { return }
    networkManager.get("\(baseURL)/users/nickname/\(id)") { data, error in
      let (decoded, error) = self.decode(to: NicknameResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
  
  func uploadNickname(id: String, nickname: String, completion: @escaping (Int?, Error?) -> Void) {
    let parameters = ["id": id, "nickname": nickname]
    networkManager
      .post("\(baseURL)/users/nickname", parameters: parameters) { _, statusCode, error in
        completion(statusCode, error)
    }
  }
}
