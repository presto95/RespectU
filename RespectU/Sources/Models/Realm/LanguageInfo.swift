//
//  LanguageInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about langugae.
final class LanguageInfo: Object {
  
  /// The english data.
  @objc dynamic var english: String = ""
  
  /// The korean data.
  @objc dynamic var korean: String?
}
