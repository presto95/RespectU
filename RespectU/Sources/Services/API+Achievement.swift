//
//  API+Achievement.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

// MARK: APIService + Achievement

extension APIService {
  
  func requestAchievements(byType type: AchievementType? = nil,
                           completion: @escaping (AchievementResponse?, Error?) -> Void) {
    let urlString: String
    if case let type? = type {
      urlString = "\(baseURL)/achievements/\(type.rawValue)"
    } else {
      urlString = "\(baseURL)/achievements"
    }
    networkManager.get(urlString) { data, error in
      let (decoded, error) = self.decode(to: AchievementResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
}
