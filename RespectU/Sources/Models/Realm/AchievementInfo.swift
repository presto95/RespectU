//
//  AchievementInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about achievement.
final class AchievementInfo: Object {
  
  /// The type of the achievement.
  @objc dynamic var type: String = ""
  
  /// The level of the achievement.
  @objc dynamic var level: Int = 0
  
  /// The section of the achievement.
  @objc dynamic var section: LanguageInfo?
  
  /// The item of the achievement.
  @objc dynamic var item: LanguageInfo?
  
  /// The localized section of the achievement.
  var localizedSection: String {
    if isInKorea, let korean = section?.korean {
      return korean
    } else {
      return section?.english ?? ""
    }
  }
  
  /// The localized item of the achievement.
  var localizedItem: String {
    if isInKorea, let korean = item?.korean {
      return korean
    } else {
      return item?.english ?? ""
    }
  }
  
  /// The achievement type of the achievement.
  var typeEnum: AchievementType? {
    return AchievementType(rawValue: type)
  }
  
  /// Adds the `achievementInfo` to realm.
  ///
  /// - Parameter achievementInfo: The achievement information will be added.
  static func add(_ achievementInfo: AchievementResponse.Achievement) {
    let realm = try! Realm()
    let object = AchievementInfo()
    let sectionInfo = LanguageInfo()
    let itemInfo = LanguageInfo()
    object.type = achievementInfo.type
    object.level = achievementInfo.level
    sectionInfo.english = achievementInfo.section.english
    sectionInfo.korean = achievementInfo.section.korean
    itemInfo.english = achievementInfo.item.english
    itemInfo.korean = achievementInfo.item.korean
    object.section = sectionInfo
    object.item = itemInfo
    try! realm.write {
      realm.add(object)
    }
  }
  
  /// Fetches achievements of specific `type`.
  ///
  /// - Parameter type: The `AchievementType` filtered by this value.
  ///
  /// - Returns: The fetched achievements.
  static func fetch(byType type: AchievementType) -> Results<AchievementInfo> {
    let achievementInfo = try! Realm().objects(AchievementInfo.self)
    if case .all = type {
      return achievementInfo
    } else {
      return achievementInfo.filter("type = \(type.rawValue)")
    }
  }
  
  /// Updates `achievementInfo` to `object`.
  ///
  /// - Parameters:
  ///   - object:           The source achievement information.
  ///   - achievementInfo:  The updated achievement information.
  static func update(_ object: AchievementResponse.Achievement,
                     to achievementInfo: AchievementInfo) {
    let realm = try! Realm()
    try! realm.write {
      achievementInfo.type = object.type
      achievementInfo.level = object.level
      achievementInfo.section?.english = object.section.english
      achievementInfo.section?.korean = object.section.korean
      achievementInfo.item?.english = object.item.english
      achievementInfo.item?.korean = object.item.korean
    }
  }
}
