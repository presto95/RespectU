//
//  Results+.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

extension Results {
  
  @discardableResult
  func filter(key: String, value: String, method: String) -> Results {
    return self.filter("\(key) \(method) '\(value)'")
  }
}
