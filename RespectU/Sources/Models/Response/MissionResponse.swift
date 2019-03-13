//
//  MissionResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about mission.
struct MissionResponse: Codable {
  
  /// The mission data in the mission response object.
  struct Mission: Codable {
    
    /// The stage data in the mission response object.
    struct Stage: Codable {
      
      /// The title of the mission.
      let title: LanguageResponse
      
      /// The difficulty of the mission.
      let difficulty: String
      
      /// The button of the mission.
      let button: String
      
      /// The localized title of the mission.
      var localizedTitle: String {
        if Locale.current.regionCode == "KR", let korean = title.korean {
          return korean
        } else {
          return title.english
        }
      }
    }
    
    /// The series of the mission.
    let series: String
    
    /// The section of the mission.
    let section: String
    
    /// The title of the mission.
    let title: String
    
    /// The score limit of the mission.
    let score: Int
    
    /// The fever limit of the mission.
    let fever: Int
    
    /// The combo limit of the mission.
    let combo: Int
    
    /// The rate limit of the mission.
    let rate: Int
    
    /// The break limit of the mission.
    let `break`: Int
    
    /// The effector of the mission.
    let effector: String
    
    /// The reward of the mission.
    let reward: LanguageResponse
    
    /// The information about first stage of the mission.
    let stage1: Stage?
    
    /// The information about second stage of the mission.
    let stage2: Stage?
    
    /// The information about third stage of the mission.
    let stage3: Stage?
    
    /// The information about fourth stage of the mission.
    let stage4: Stage?
    
    /// The information about fifth stage of the mission.
    let stage5: Stage?
    
    /// The information about sixth stage of the mission.
    let stage6: Stage?
    
    /// The localized reward of the mission.
    var localizedReward: String {
      if Locale.current.regionCode == "KR", let korean = reward.korean {
        return korean
      } else {
        return reward.english
      }
    }
  }
  
  /// The missions.
  let missions: [Mission]
  
  /// The number of `missions`.
  var count: Int {
    return missions.count
  }
  
  /// Accesses the `index`th element in `missions`.
  subscript(index: Int) -> Mission {
    return missions[index]
  }
}
