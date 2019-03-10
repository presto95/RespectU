//
//  TipResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about tip.
struct TipResponse: Codable {
  
  /// The tip data in the tip response object.
  struct Tip: Codable {
    
    /// The title of the tip.
    let title: LanguageResponse
    
    /// The localized title of the tip.
    var localizedTitle: String {
      if Locale.current.regionCode == "KR", let korean = title.korean {
        return korean
      } else {
        return title.english
      }
    }
  }
  
  /// The tips.
  let tips: [Tip]
  
  /// The number of `tips`.
  var count: Int {
    return tips.count
  }
  
  /// Accesses the `index`th element in `tips`.
  subscript(index: Int) -> Tip {
    return tips[index]
  }
}
