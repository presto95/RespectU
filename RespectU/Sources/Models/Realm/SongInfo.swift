//
//  SongInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about song.
final class SongInfo: Object {
  
  /// The title of the song.
  @objc dynamic var title: LanguageInfo?
  
  /// The losercased title of the song.
  @objc dynamic var lowercase: LanguageInfo?
  
  /// The series of the song.
  @objc dynamic var series: String = ""
  
  /// The composer of the song.
  @objc dynamic var composer: String = ""
  
  /// The bpm of the song.
  @objc dynamic var bpm: Int = 0
  
  /// The sub bpm of the song.
  ///
  /// If this value is not nil, this song has variant bpm.
  /// In this case, `bpm` becomes the minimum bpm and `subBpm` becomes the maximum bpm.
  let subBPM: RealmOptional<Int> = RealmOptional<Int>()
  
  /// The information about 4B of the song.
  @objc dynamic var button4: SongButtonInfo?
  
  /// The information about 5B of the song.
  @objc dynamic var button5: SongButtonInfo?
  
  /// The information about 6B of the song.
  @objc dynamic var button6: SongButtonInfo?
  
  /// The information about 8B of the song.
  @objc dynamic var button8: SongButtonInfo?
  
  /// The localized title of the song.
  var localizedTitle: String {
    if isInKorea, let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  
  /// The localized lowercased title of the song.
  var localizedLowercase: String {
    if isInKorea, let korean = lowercase?.korean {
      return korean
    } else {
      return lowercase?.english ?? ""
    }
  }
  
  /// The `Series` of the song.
  var seriesEnum: Series? {
    return Series(rawValue: series)
  }
  
  /// The string value conveted by `bpm` and `subBPM`.
  ///
  /// `bpm == 130, subBPM == nil` -> "BPM 130"
  /// `bpm == 130, subBPM == 153` -> "BPM 130 ~ 153"
  var bpmToString: String {
    if let subBpm = subBPM.value {
      return "BPM \(bpm) ~ \(subBpm)"
    } else {
      return "BPM \(bpm)"
    }
  }
  
  /// Adds the `songInfo` to realm.
  ///
  /// - Parameter songInfo: The song information will be added.
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
    object.subBPM.value = songInfo.subBpm
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
  
  /// Fetches songs of specific `series`.
  ///
  /// - Parameter series: The `Series` filtered by this value. The default value is `nil`.
  ///
  /// - Note: If `series` is `nil`, it fetches all saved songs.
  ///
  /// - Returns: The fetched songs.
  static func fetch(bySeries series: Series? = nil) -> Results<SongInfo> {
    let songInfo = try! Realm().objects(SongInfo.self)
    if case let series? = series {
      return songInfo.filter("series = \(series.rawValue)")
    } else {
      return songInfo
    }
  }
  
  /// Fetches songs of specific `title`.
  ///
  /// - Parameter series: The `title` filtered by this value.
  ///
  /// - Returns: The fetched songs.
  static func fetch(byTitle title: String) -> SongInfo? {
    let predicate = NSPredicate(format: "%K == %@", #keyPath(SongInfo.title.english), title)
    return try! Realm().objects(SongInfo.self).filter(predicate).first
  }
  
  /// Updates `songInfo` to `object`.
  ///
  /// - Parameters:
  ///   - object:   The source song information.
  ///   - songInfo: The updated song information.
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
      songInfo.subBPM.value = object.subBpm
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
