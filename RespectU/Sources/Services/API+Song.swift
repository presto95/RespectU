//
//  API+Song.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

// MARK: APIService + Song

extension APIService {
  
  func requestSongs(bySeries series: Series? = nil,
                    completion: @escaping (SongResponse?, Error?) -> Void) {
    let urlString: String
    if case let series? = series {
      urlString = "\(baseURL)/songs/\(series.rawValue)"
    } else {
      urlString = "\(baseURL)/songs"
    }
    networkManager.get(urlString) { data, error in
      let (decoded, error) = self.decode(to: SongResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
}
