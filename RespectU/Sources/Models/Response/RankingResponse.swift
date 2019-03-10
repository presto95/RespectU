//
//  Ranking.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about ranking.
struct RankingResponse: Codable {
  
  /// The ranking data in the ranking response object.
  struct Ranking: Codable {
    
    /// The user identifier.
    let id: String
    
    /// The nickname.
    let nickname: String
    
    /// The 4B tunes skill point.
    let button4: Double
    
    /// The 5B tunes skill point.
    let button5: Double
    
    /// The 6B tunes skill point.
    let button6: Double
    
    /// The 8B tunes skill point.
    let button8: Double
  }
  
  /// The rankings.
  let rankings: [Ranking]
}
