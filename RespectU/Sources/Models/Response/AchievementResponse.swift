//
//  AchievementResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about achievement.
struct AchievementResponse: Codable {
  
  /// The achievement data in the achievement response object.
  struct Achievement: Codable {
    
    /// The type of the achievement.
    let type: String
    
    /// The level of the achievement.
    let level: Int
    
    /// The section of the achievement.
    let section: LanguageResponse
    
    /// The item of the achievement.
    let item: LanguageResponse
    
    /// The localized section of the achievement.
    var localizedSection: String {
      if Locale.current.regionCode == "KR", let korean = section.korean {
        return korean
      } else {
        return section.english
      }
    }
    
    /// The localized item of the achievement.
    var localizedItem: String {
      if Locale.current.regionCode == "KR", let korean = item.korean {
        return korean
      } else {
        return item.english
      }
    }
  }
  
  /// The achievements.
  let achievements: [Achievement]
  
  /// The number of `achievements`.
  var count: Int {
    return achievements.count
  }
  
  /// Accesses the `index`th element in `achievements`.
  subscript(index: Int) -> Achievement {
    return achievements[index]
  }
}
