//
//  MissionInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about mission.
final class MissionInfo: Object {
  
  /// The series of the mission.
  @objc dynamic var series: String = ""
  
  /// The section of the mission.
  @objc dynamic var section: String = ""
  
  /// The title of the mission.
  @objc dynamic var title: String = ""
  
  /// The score limit of the mission.
  @objc dynamic var score: Int = 0
  
  /// The fever limit of the mission.
  @objc dynamic var fever: Int = 0
  
  /// The combo limit of the mission.
  @objc dynamic var combo: Int = 0
  
  /// The rate limit of the mission.
  @objc dynamic var rate: Int = 0
  
  /// The break limit of the mission.
  @objc dynamic var `break`: Int = 0
  
  /// The effector of the mission.
  @objc dynamic var effector: String = ""
  
  /// The reward of the mission.
  @objc dynamic var reward: LanguageInfo?
  
  /// The information about first stage of the mission.
  @objc dynamic var stage1: MissionStageInfo?
  
  /// The information about second stage of the mission.
  @objc dynamic var stage2: MissionStageInfo?
  
  /// The information about third stage of the mission.
  @objc dynamic var stage3: MissionStageInfo?
  
  /// The informatio about fourth stage of the mission.
  @objc dynamic var stage4: MissionStageInfo?
  
  /// The information about fifth stage of the mission.
  @objc dynamic var stage5: MissionStageInfo?
  
  /// The information about sixth stage of the mission.
  @objc dynamic var stage6: MissionStageInfo?
  
  /// The localized reward of the mission.
  var localizedReward: String {
    if isInKorea, let korean = reward?.korean {
      return korean
    } else {
      return reward?.english ?? ""
    }
  }
  
  /// The `Series` of the mission.
  var seriesEnum: Series? {
    return Series(rawValue: series)
  }
  
  /// Adds the `missionInfo` to realm.
  ///
  /// - Parameter missionInfo: The mission information will be added.
  static func add(_ missionInfo: MissionResponse.Mission) {
    let realm = try! Realm()
    let object = MissionInfo()
    let rewardInfo = LanguageInfo()
    object.series = missionInfo.series
    object.section = missionInfo.section
    object.title = missionInfo.title
    object.score = missionInfo.score
    object.combo = missionInfo.combo
    object.rate = missionInfo.rate
    object.break = missionInfo.break
    object.effector = missionInfo.effector
    rewardInfo.english = missionInfo.reward.english
    rewardInfo.korean = missionInfo.reward.korean
    object.reward = rewardInfo
    if let stage = missionInfo.stage1 {
      let stageInfo = MissionStageInfo()
      let titleInfo = LanguageInfo()
      titleInfo.english = stage.title.english
      titleInfo.korean = stage.title.korean
      stageInfo.title = titleInfo
      stageInfo.difficulty = stage.difficulty
      stageInfo.button = stage.button
      object.stage1 = stageInfo
    }
    if let stage = missionInfo.stage2 {
      let stageInfo = MissionStageInfo()
      let titleInfo = LanguageInfo()
      titleInfo.english = stage.title.english
      titleInfo.korean = stage.title.korean
      stageInfo.title = titleInfo
      stageInfo.difficulty = stage.difficulty
      stageInfo.button = stage.button
      object.stage2 = stageInfo
    }
    if let stage = missionInfo.stage3 {
      let stageInfo = MissionStageInfo()
      let titleInfo = LanguageInfo()
      titleInfo.english = stage.title.english
      titleInfo.korean = stage.title.korean
      stageInfo.title = titleInfo
      stageInfo.difficulty = stage.difficulty
      stageInfo.button = stage.button
      object.stage3 = stageInfo
    }
    if let stage = missionInfo.stage4 {
      let stageInfo = MissionStageInfo()
      let titleInfo = LanguageInfo()
      titleInfo.english = stage.title.english
      titleInfo.korean = stage.title.korean
      stageInfo.title = titleInfo
      stageInfo.difficulty = stage.difficulty
      stageInfo.button = stage.button
      object.stage4 = stageInfo
    }
    if let stage = missionInfo.stage5 {
      let stageInfo = MissionStageInfo()
      let titleInfo = LanguageInfo()
      titleInfo.english = stage.title.english
      titleInfo.korean = stage.title.korean
      stageInfo.title = titleInfo
      stageInfo.difficulty = stage.difficulty
      stageInfo.button = stage.button
      object.stage5 = stageInfo
    }
    if let stage = missionInfo.stage6 {
      let stageInfo = MissionStageInfo()
      let titleInfo = LanguageInfo()
      titleInfo.english = stage.title.english
      titleInfo.korean = stage.title.korean
      stageInfo.title = titleInfo
      stageInfo.difficulty = stage.difficulty
      stageInfo.button = stage.button
      object.stage6 = stageInfo
    }
    try! realm.write {
      realm.add(object)
    }
  }
  
  /// Fetches missions of specific `series`.
  ///
  /// - Parameter series: The `Series` filtered by this value. The default value is `nil`.
  ///
  /// - Note: If `series` is `nil`, it fetches all saved missions.
  ///
  /// - Returns: The fetched missions.
  static func fetch(bySeries series: Series? = nil) -> Results<MissionInfo> {
    let realm = try! Realm()
    let missionInfo = realm.objects(MissionInfo.self)
    if case let series? = series {
      return missionInfo.filter("series = \(series.rawValue)")
    } else {
      return missionInfo
    }
  }
  
  /// Updates `missionInfo` to `object`.
  ///
  /// - Parameters:
  ///   - object:           The source mission information.
  ///   - achievementInfo:  The updated mission information.
  static func update(_ object: MissionResponse.Mission, to missionInfo: MissionInfo) {
    let realm = try! Realm()
    try! realm.write {
      missionInfo.series = object.series
      missionInfo.section = object.section
      missionInfo.title = object.title
      missionInfo.score = object.score
      missionInfo.fever = object.fever
      missionInfo.combo = object.combo
      missionInfo.rate = object.rate
      missionInfo.break = object.break
      missionInfo.effector = object.effector
      missionInfo.reward?.english = object.reward.english
      missionInfo.reward?.korean = object.reward.korean
    }
  }
}
