//
//  Ranking.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct RankingResponse: Codable {
  
  struct Ranking: Codable {
    
    let id: String
    
    let nickname: String
    
    let button4: Double
    
    let button5: Double
    
    let button6: Double
    
    let button8: Double
  }
  
  let rankings: [Ranking]
}
