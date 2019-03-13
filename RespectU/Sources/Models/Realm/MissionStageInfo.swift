//
//  MissionStageInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about stage information of a mission.
final class MissionStageInfo: Object {
  
  /// The title of the stage.
  @objc dynamic var title: LanguageInfo?
  
  /// The difficulty of the stage.
  @objc dynamic var difficulty: String = ""
  
  /// The button of the stage.
  @objc dynamic var button: String = ""
  
  /// The localized title of the stage.
  var localizedTitle: String {
    if isInKorea, let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
  
  /// The `Difficulty` of the stage.
  var difficultyEnum: Difficulty? {
    return Difficulty(rawValue: difficulty)
  }
  
  /// The `Button` of the stage.
  var buttonEnum: Button? {
    return Button(rawValue: button)
  }
}
