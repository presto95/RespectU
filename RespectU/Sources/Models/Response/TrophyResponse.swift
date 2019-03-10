//
//  TrophyResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about trophy.
struct TrophyResponse: Codable {
  
  /// The trophy data in the trophy response object.
  struct Trophy: Codable {
    
    /// The series of the trophy.
    let series: String
    
    /// The rating of the trophy.
    let rating: String
    
    /// The image name of the trophy.
    let image: String
    
    /// The title of the trophy.
    let title: LanguageResponse
    
    /// The content of the trophy.
    let content: LanguageResponse
    
    /// The localized title of the trophy.
    var localizedTitle: String {
      if Locale.current.regionCode == "KR", let korean = title.korean {
        return korean
      } else {
        return title.english
      }
    }
    
    /// The localized content of the trophy.
    var localizedContent: String {
      if Locale.current.regionCode == "KR", let korean = content.korean {
        return korean
      } else {
        return content.english
      }
    }
  }
  
  /// The trophies.
  let trophies: [Trophy]
  
  /// The number of `trophies`.
  var count: Int {
    return trophies.count
  }
  
  /// Accesses the `index`th element in `trophies`.
  subscript(index: Int) -> Trophy {
    return trophies[index]
  }
}
