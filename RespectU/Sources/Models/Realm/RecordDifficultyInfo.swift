//
//  RecordPerformanceInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about difficulty information on a record.
final class RecordDifficultyInfo: Object {
  
  /// The rank in the difficulty in the button of the record.
  @objc dynamic var rank: String = ""
  
  /// The rate in the difficulty in the button of the record.
  @objc dynamic var rate: Double = 0
  
  /// The note in the difficulty in the button of the record.
  @objc dynamic var note: String = ""
  
  /// The `Rank` in the difficulty in the button of the record.
  var rankEnum: Rank? {
    return Rank(rawValue: rank)
  }
  
  /// The rank with percent symbol in the difficulty in the button of the record.
  var rateWithPercent: String {
    return "\(rate)%"
  }
  
  /// The `Note` in the difficulty in the button of the record.
  var noteEnum: Note? {
    return Note(rawValue: note)
  }
}
