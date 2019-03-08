//
//  TrophyResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct TrophyResponse: Codable {
  
  struct Trophy: Codable {
    
    let series: String
    
    let rating: String
    
    let image: String
    
    let title: LanguageResponse
    
    let content: LanguageResponse
    
    var localizedTitle: String {
      if Locale.current.regionCode == "KR", let korean = title.korean {
        return korean
      } else {
        return title.english
      }
    }
    
    var localizedContent: String {
      if Locale.current.regionCode == "KR", let korean = content.korean {
        return korean
      } else {
        return content.english
      }
    }
  }
  
  let trophies: [Trophy]
  
  var count: Int {
    return trophies.count
  }
  
  subscript(index: Int) -> Trophy {
    return trophies[index]
  }
}
