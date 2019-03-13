//
//  StringExtension.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 17..
//  Copyright © 2017년 Presto. All rights reserved.
//

import Foundation

extension String {
  
  /// The localized string.
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
}
