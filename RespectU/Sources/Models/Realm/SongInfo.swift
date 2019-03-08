//
//  SongInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

final class SongInfo: Object {
  
  @objc dynamic var title: LanguageInfo?
  
  @objc dynamic var lowercase: LanguageInfo?
  
  @objc dynamic var series: String = ""
  
  @objc dynamic var composer: String = ""
  
  @objc dynamic var bpm: Int = 0
  
  let subBpm: RealmOptional<Int> = RealmOptional<Int>()
  
  @objc dynamic var button4: SongButtonInfo?
  
  @objc dynamic var button5: SongButtonInfo?
  
  @objc dynamic var button6: SongButtonInfo?
  
  @objc dynamic var button8: SongButtonInfo?
  
  var localizedTitle: String {
    if regionCode == "KR", let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  var localizedLowercase: String {
    if regionCode == "KR", let korean = lowercase?.korean {
      return korean
    } else {
      return lowercase?.english ?? ""
    }
  }
  var bpmToString: String {
    if let subBpm = subBpm.value {
      return "BPM \(bpm) ~ \(subBpm)"
    } else {
      return "BPM \(bpm)"
    }
  }
  
  static func add(_ songInfo: SongResponse.Song) {
    let realm = try! Realm()
    let object = SongInfo()
    let titleInfo = LanguageInfo()
    let lowercaseInfo = LanguageInfo()
    let button4Info = SongButtonInfo()
    let button5Info = SongButtonInfo()
    let button6Info = SongButtonInfo()
    let button8Info = SongButtonInfo()
    object.series = songInfo.series
    object.composer = songInfo.composer
    object.bpm = songInfo.bpm
    object.subBpm.value = songInfo.subBpm
    titleInfo.english = songInfo.title.english
    titleInfo.korean = songInfo.title.korean
    object.title = titleInfo
    lowercaseInfo.english = songInfo.lowercase.english
    lowercaseInfo.korean = songInfo.lowercase.korean
    object.lowercase = lowercaseInfo
    button4Info.normal = songInfo.button4.normal
    button4Info.hard = songInfo.button4.hard
    button4Info.maximum = songInfo.button4.maximum
    object.button4 = button4Info
    button5Info.normal = songInfo.button5.normal
    button5Info.hard = songInfo.button5.hard
    button5Info.maximum = songInfo.button5.maximum
    object.button5 = button5Info
    button6Info.normal = songInfo.button6.normal
    button6Info.hard = songInfo.button6.hard
    button6Info.maximum = songInfo.button6.maximum
    object.button6 = button6Info
    button8Info.normal = songInfo.button8.normal
    button8Info.hard = songInfo.button8.hard
    button8Info.maximum = songInfo.button8.maximum
    object.button8 = button8Info
    try! realm.write {
      realm.add(object)
    }
  }
  
  /// 시리즈별 음악 가져오기
  static func fetch(of series: String = "") -> Results<SongInfo> {
    let songInfo = try! Realm().objects(SongInfo.self)
    if series.isEmpty {
      return songInfo
    } else {
      let filtered = songInfo.filter(key: "series", value: series, method: "=")
      return filtered
    }
  }
  
  /// 타이틀별 음악 가져오기
  static func fetch(by title: String) -> SongInfo? {
    let predicate = NSPredicate(format: "%K == %@", #keyPath(SongInfo.title.english), title)
    return try! Realm().objects(SongInfo.self).filter(predicate).first
  }
  
  /// 타이틀로 필터링한 내부 데이터베이스 갱신
  static func update(_ object: SongResponse.Song, to songInfo: SongInfo) {
    let realm = try! Realm()
    try! realm.write {
      songInfo.title?.english = object.title.english
      songInfo.title?.korean = object.title.korean
      songInfo.lowercase?.english = object.lowercase.english
      songInfo.lowercase?.korean = object.lowercase.korean
      songInfo.series = object.series
      songInfo.composer = object.composer
      songInfo.bpm = object.bpm
      songInfo.subBpm.value = object.subBpm
      songInfo.button4?.normal = object.button4.normal
      songInfo.button4?.hard = object.button4.hard
      songInfo.button4?.maximum = object.button4.maximum
      songInfo.button5?.normal = object.button5.normal
      songInfo.button5?.hard = object.button5.hard
      songInfo.button5?.maximum = object.button5.maximum
      songInfo.button6?.normal = object.button6.normal
      songInfo.button6?.hard = object.button6.hard
      songInfo.button6?.maximum = object.button6.maximum
      songInfo.button8?.normal = object.button8.normal
      songInfo.button8?.hard = object.button8.hard
      songInfo.button8?.maximum = object.button8.maximum
    }
  }
}
