//
//  API+Trophy.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

// MARK: APIService + Trophy

extension APIService {
  
  func requestTrophies(bySeries series: Series? = nil,
                       completion: @escaping (TrophyResponse?, Error?) -> Void) {
    let urlString: String
    if case let series? = series {
      urlString = "\(baseURL)/trophies/\(series.rawValue)"
    } else {
      urlString = "\(baseURL)/trophies"
    }
    networkManager.get(urlString) { data, error in
      let (decoded, error) = self.decode(to: TrophyResponse.self, data: data, error: error)
      completion(decoded, error)    }
  }
}
