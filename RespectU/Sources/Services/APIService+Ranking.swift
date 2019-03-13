//
//  API+Ranking.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

// MARK: APIService + Ranking

extension APIService {
  
  func requestRankings(completion: @escaping (RankingResponse?, Error?) -> Void) {
    networkManager.get("\(baseURL)/rankings") { data, error in
      let (decoded, error) = self.decode(to: RankingResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
  
  func uploadRanking(id: String,
                     nickname: String,
                     button4: Double,
                     button5: Double,
                     button6: Double,
                     button8: Double,
                     completion: @escaping (Int?, Error?) -> Void) {
    let parameters: [String: Any] = [
      "id": id,
      "nickname": nickname,
      "button4": button4,
      "button5": button5,
      "button6": button6,
      "button8": button8
    ]
    networkManager.post("\(baseURL)/rankings", parameters: parameters) { _, statusCode, error in
      completion(statusCode, error)
    }
  }
}
