//
//  RecordInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about record.
final class RecordInfo: Object {
  
  /// The title of the record.
  @objc dynamic var title: LanguageInfo?
  
  /// The series of the record.
  @objc dynamic var series: String = ""
  
  /// The information about 4B TUNES.
  @objc dynamic var button4: RecordButtonInfo?
  
  /// The information about 5B TUNES.
  @objc dynamic var button5: RecordButtonInfo?
  
  /// The information about 6B TUNES.
  @objc dynamic var button6: RecordButtonInfo?
  
  /// The information about 8B TUNES.
  @objc dynamic var button8: RecordButtonInfo?
  
  /// The localized title of the record.
  var localizedTitle: String {
    if isInKorea, let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  
  /// The `Series` of the record.
  var seriesEnum: Series? {
    return Series(rawValue: series)
  }
  
  /// Adds the `recordInfo` to realm.
  ///
  /// - Parameter recordInfo: The record information will be added.
  static func add(_ recordInfo: RecordInfo) {
    let realm = try! Realm()
    let object = RecordInfo()
    object.title = recordInfo.title
    object.series = recordInfo.series
    object.button4 = recordInfo.button4
    object.button5 = recordInfo.button5
    object.button6 = recordInfo.button6
    object.button8 = recordInfo.button8
    try! realm.write {
      realm.add(object)
    }
  }
  
  /// Fetches records of specific `title`.
  ///
  /// - Parameter title: The `title` filtered by this value. The default value is `""`.
  ///
  /// - Returns: The fetched records.
  static func fetch(byTitle title: String = "") -> Results<RecordInfo> {
    let recordInfo = try! Realm().objects(RecordInfo.self)
    if title.isEmpty {
      return recordInfo
    } else {
      return recordInfo.filter("title = \(title)")
    }
  }
  
  static func update(_ object: RecordInfo, with dictionary: [String: Any]) {
    let realm = try! Realm()
    try! realm.write {
      for (key, value) in dictionary {
        object.setValue(value, forKeyPath: key)
      }
    }
  }
  
  static func update(_ object: RecordResponse.Record, to recordInfo: RecordInfo) {
    let realm = try! Realm()
    try! realm.write {
      recordInfo.title?.english = object.title.english
      recordInfo.title?.korean = object.title.korean
      recordInfo.series = object.series
      recordInfo.button4?.normal?.rank = object.button4.normal.rank
      recordInfo.button4?.normal?.rate = object.button4.normal.rate
      recordInfo.button4?.normal?.note = object.button4.normal.note
      recordInfo.button4?.hard?.rank = object.button4.hard.rank
      recordInfo.button4?.hard?.rate = object.button4.hard.rate
      recordInfo.button4?.hard?.note = object.button4.hard.note
      recordInfo.button4?.maximum?.rank = object.button4.maximum.rank
      recordInfo.button4?.maximum?.rate = object.button4.maximum.rate
      recordInfo.button4?.maximum?.note = object.button4.maximum.note
      recordInfo.button4?.skillPoint = object.button4.skillPoint
      recordInfo.button4?.skillPointNote = object.button4.skillPointNote
      recordInfo.button4?.skillPointRate = object.button4.skillPointRate
      recordInfo.button4?.skillPointDifficulty = object.button4.skillPointDifficulty
      recordInfo.button5?.normal?.rank = object.button5.normal.rank
      recordInfo.button5?.normal?.rate = object.button5.normal.rate
      recordInfo.button5?.normal?.note = object.button5.normal.note
      recordInfo.button5?.hard?.rank = object.button5.hard.rank
      recordInfo.button5?.hard?.rate = object.button5.hard.rate
      recordInfo.button5?.hard?.note = object.button5.hard.note
      recordInfo.button5?.maximum?.rank = object.button5.maximum.rank
      recordInfo.button5?.maximum?.rate = object.button5.maximum.rate
      recordInfo.button5?.maximum?.note = object.button5.maximum.note
      recordInfo.button5?.skillPoint = object.button5.skillPoint
      recordInfo.button5?.skillPointNote = object.button5.skillPointNote
      recordInfo.button5?.skillPointRate = object.button5.skillPointRate
      recordInfo.button5?.skillPointDifficulty = object.button5.skillPointDifficulty
      recordInfo.button6?.normal?.rank = object.button6.normal.rank
      recordInfo.button6?.normal?.rate = object.button6.normal.rate
      recordInfo.button6?.normal?.note = object.button6.normal.note
      recordInfo.button6?.hard?.rank = object.button6.hard.rank
      recordInfo.button6?.hard?.rate = object.button6.hard.rate
      recordInfo.button6?.hard?.note = object.button6.hard.note
      recordInfo.button6?.maximum?.rank = object.button6.maximum.rank
      recordInfo.button6?.maximum?.rate = object.button6.maximum.rate
      recordInfo.button6?.maximum?.note = object.button6.maximum.note
      recordInfo.button6?.skillPoint = object.button6.skillPoint
      recordInfo.button6?.skillPointNote = object.button6.skillPointNote
      recordInfo.button6?.skillPointRate = object.button6.skillPointRate
      recordInfo.button6?.skillPointDifficulty = object.button6.skillPointDifficulty
      recordInfo.button8?.normal?.rank = object.button8.normal.rank
      recordInfo.button8?.normal?.rate = object.button8.normal.rate
      recordInfo.button8?.normal?.note = object.button8.normal.note
      recordInfo.button8?.hard?.rank = object.button8.hard.rank
      recordInfo.button8?.hard?.rate = object.button8.hard.rate
      recordInfo.button8?.hard?.note = object.button8.hard.note
      recordInfo.button8?.maximum?.rank = object.button8.maximum.rank
      recordInfo.button8?.maximum?.rate = object.button8.maximum.rate
      recordInfo.button8?.maximum?.note = object.button8.maximum.note
      recordInfo.button8?.skillPoint = object.button8.skillPoint
      recordInfo.button8?.skillPointNote = object.button8.skillPointNote
      recordInfo.button8?.skillPointRate = object.button8.skillPointRate
      recordInfo.button8?.skillPointDifficulty = object.button8.skillPointDifficulty
      
    }
  }
}
