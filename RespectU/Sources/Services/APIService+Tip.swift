//
//  API+Tip.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

// MARK: APIService + Tip

extension APIService {
  
  func requestTips(completion: @escaping (TipResponse?, Error?) -> Void) {
    networkManager.get("\(baseURL)/tips") { data, error in
      let (decoded, error) = self.decode(to: TipResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
}
