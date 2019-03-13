//
//  API+Record.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

// MARK: APIService + Record

extension APIService {
  
  func requestRecords(id: String, completion: @escaping (RecordResponse?, Error?) -> Void) {
    networkManager.get("\(baseURL)/records/\(id)") { data, error in
      let (decoded, error) = self.decode(to: RecordResponse.self, data: data, error: error)
      completion(decoded, error)
    }
  }
  
  func uploadRecords(_ data: Data, completion: @escaping (Int?, Error?) -> Void) {
    networkManager.upload(data, to: "\(baseURL)/records") { _, statusCode, error in
      completion(statusCode, error)
    }
  }
}
