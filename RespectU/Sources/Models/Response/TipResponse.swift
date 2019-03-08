//
//  TipResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct TipResponse: Codable {
  
  struct Tip: Codable {
    
    let title: LanguageResponse
    
    var localizedTitle: String {
      if Locale.current.regionCode == "KR", let korean = title.korean {
        return korean
      } else {
        return title.english
      }
    }
  }
  
  let tips: [Tip]
  
  var count: Int {
    return tips.count
  }
  
  subscript(index: Int) -> Tip {
    return tips[index]
  }
}
