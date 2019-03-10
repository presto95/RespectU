//
//  TrophyInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about trophy.
final class TrophyInfo: Object {
  
  /// The series of the trophy.
  @objc dynamic var series: String = ""
  
  /// The rating of the trophy.
  @objc dynamic var rating: String = ""
  
  /// The image name of the trophy.
  @objc dynamic var image: String = ""
  
  /// The title of the trophy.
  @objc dynamic var title: LanguageInfo?
  
  /// The content of the trophy.
  @objc dynamic var content: LanguageInfo?
  
  /// The localized title of the trophy.
  var localizedTitle: String {
    if isInKorea, let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  
  /// The localized content of the trophy.
  var localizedContent: String {
    if isInKorea, let korean = content?.korean {
      return korean
    } else {
      return content?.english ?? ""
    }
  }
  
  /// The `Series` of the trophy.
  var seriesEnum: Series? {
    return Series(rawValue: series)
  }
  
  /// The `TrophyGrade` of the trophy.
  var ratingEnum: TrophyGrade? {
    return TrophyGrade(rawValue: rating)
  }
  
  /// Adds the `trophyInfo` to realm.
  ///
  /// - Parameter trophyInfo: The trophy information will be added.
  static func add(_ trophyInfo: TrophyResponse.Trophy) {
    let realm = try! Realm()
    let object = TrophyInfo()
    let titleInfo = LanguageInfo()
    let contentInfo = LanguageInfo()
    object.series = trophyInfo.series
    object.rating = trophyInfo.rating
    object.image = trophyInfo.image
    let imageURL = "\(APIService.baseURL)/images/\(trophyInfo.series)/\(trophyInfo.image).png"
    guard let url = URL(string: imageURL) else { return }
    guard let imageData = try? Data(contentsOf: url) else { return }
    guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileURL = documentURL.appendingPathComponent("\(trophyInfo.image).png")
    do {
      try imageData.write(to: fileURL, options: .atomic)
    } catch {
      print(error.localizedDescription)
    }
    titleInfo.english = trophyInfo.title.english
    titleInfo.korean = trophyInfo.title.korean
    contentInfo.english = trophyInfo.content.english
    contentInfo.korean = trophyInfo.content.korean
    object.title = titleInfo
    object.content = contentInfo
    try! realm.write {
      realm.add(object)
    }
  }
  
  /// Fetches trophies of specific `series`.
  ///
  /// - Parameter series: The `Series` filtered by this value.
  ///
  /// - Returns: The fetched trophies.
  static func fetch(bySeries series: Series) -> Results<TrophyInfo> {
    let trophyInfo = try! Realm().objects(TrophyInfo.self)
    return trophyInfo.filter("series = \(series.rawValue)")
  }
  
  /// Updates `trophyInfo` to `object`.
  ///
  /// - Parameters:
  ///   - object:           The source trophy information.
  ///   - achievementInfo:  The updated trophy information.
  static func update(_ object: TrophyResponse.Trophy, to trophyInfo: TrophyInfo) {
    guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileURL = documentURL.appendingPathComponent("\(trophyInfo.image).png")
    do {
      try FileManager.default.removeItem(at: fileURL)
    } catch {
      print(error.localizedDescription)
    }
    let imageURL = "\(APIService.baseURL)/images/\(trophyInfo.series)/\(trophyInfo.image).png"
    guard let url = URL(string: imageURL) else { return }
    guard let imageData = try? Data(contentsOf: url) else { return }
    do {
      try imageData.write(to: fileURL, options: .atomic)
    } catch {
      print(error.localizedDescription)
    }
    guard let realm = try? Realm() else { return }
    try? realm.write {
      trophyInfo.series = object.series
      trophyInfo.rating = object.rating
      trophyInfo.image = object.image
      trophyInfo.title?.english = object.title.english
      trophyInfo.title?.korean = object.title.korean
      trophyInfo.content?.english = object.content.english
      trophyInfo.content?.korean = object.content.korean
    }
  }
}
