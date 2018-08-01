//
//  NSObject+.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

extension NSObject {
    var classNameToString: String {
        return NSStringFromClass(type(of: self))
    }
    static var classNameToString: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
