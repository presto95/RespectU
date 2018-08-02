//
//  Results+.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

struct FilterMethod {
    static let equal = "="
    static let greaterOrEqual = ">="
    static let greater = ">"
    static let lessOrEqual = "<="
    static let less = "<"
}

extension Results {
    @discardableResult
    func filter(key: String, value: String, method: String) -> Results {
        return self.filter("\(key) \(method) '\(value)'")
    }
    
    @discardableResult
    func sort(keyPath: String, isAscending: Bool) -> Results {
        return self.sorted(byKeyPath: keyPath, ascending: isAscending)
    }
}
