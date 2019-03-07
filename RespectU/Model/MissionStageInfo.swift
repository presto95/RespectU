//
//  MissionStageInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

final class MissionStageInfo: Object {
  
  @objc dynamic var title: LanguageInfo?
  
  @objc dynamic var difficulty: String = ""
  
  @objc dynamic var button: String = ""
  
  var localizedTitle: String {
    if regionCode == "KR", let korean = title?.korean {
      return korean
    } else {
      return title?.english ?? ""
    }
  }
}
