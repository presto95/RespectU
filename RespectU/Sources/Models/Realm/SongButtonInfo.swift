//
//  SongButtonInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about information in the button.
final class SongButtonInfo: Object {
  
  /// The normal difficulty value in the button.
  @objc dynamic var normal: Int = 0
  
  /// The hard difficulty value in the button.
  @objc dynamic var hard: Int = 0
  
  /// The maximum difficulty value in the button.
  @objc dynamic var maximum: Int = 0
}
