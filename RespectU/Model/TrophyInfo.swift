//
//  TrophyInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

final class TrophyInfo: Object {
  
  @objc dynamic var series: String = ""
  
  @objc dynamic var rating: String = ""
  
  @objc dynamic var image: String = ""
  
  @objc dynamic var title: LanguageInfo?
  
  @objc dynamic var content: LanguageInfo?
  
  var localizedTitle: String {
    if regionCode == "KR", let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  var localizedContent: String {
    if regionCode == "KR", let korean = content?.korean {
      return korean
    } else {
      return content?.english ?? ""
    }
  }
  
  static func add(_ trophyInfo: TrophyResponse.Trophy) {
    let realm = try! Realm()
    let object = TrophyInfo()
    let titleInfo = LanguageInfo()
    let contentInfo = LanguageInfo()
    object.series = trophyInfo.series
    object.rating = trophyInfo.rating
    object.image = trophyInfo.image
    let imageURL = "\(API.baseURL)/images/\(trophyInfo.series)/\(trophyInfo.image).png"
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
  
  static func fetch(of series: String = "") -> Results<TrophyInfo> {
    let trophyInfo = try! Realm().objects(TrophyInfo.self)
    if series.isEmpty {
      return trophyInfo
    } else {
      let filtered = trophyInfo.filter(key: "series", value: series, method: "=")
      return filtered
    }
  }
  
  ///타이틀로 필터링한 내부 데이터베이스 갱신
  static func update(_ object: TrophyResponse.Trophy, to trophyInfo: TrophyInfo) {
    guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileURL = documentURL.appendingPathComponent("\(trophyInfo.image).png")
    do {
      try FileManager.default.removeItem(at: fileURL)
    } catch {
      print(error.localizedDescription)
    }
    let imageURL = "\(API.baseURL)/images/\(trophyInfo.series)/\(trophyInfo.image).png"
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
