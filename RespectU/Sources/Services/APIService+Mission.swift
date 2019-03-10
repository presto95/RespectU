//
//  API+Mission.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

// MARK: APIService + Mission

extension APIService {
  
  func requestMissions(bySeries series: Series? = nil,
                       completion: @escaping (MissionResponse?, Error?) -> Void) {
    let urlString: String
    if case let series? = series {
      urlString = "\(baseURL)/missions/\(series.rawValue)"
    } else {
      urlString = "\(baseURL)/missions"
    }
    networkManager.get(urlString) { data, error in
      let (decoded, error) = self.decode(to: MissionResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
}
