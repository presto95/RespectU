//
//  RecordResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct RecordResponse: Codable {
  
  struct Record: Codable {
    
    struct Button: Codable {
      
      struct Difficulty: Codable {
        
        let rank: String
        
        let rate: Double
        
        let note: String
      }
      
      let normal: Difficulty
      
      let hard: Difficulty
      
      let maximum: Difficulty
      
      let skillPoint: Double
      
      let skillPointDifficulty: String
      
      let skillPointNote: String
      
      let skillPointRate: Double
    }
    
    let title: LanguageResponse
    
    let series: String
    
    let button4: Button
    
    let button5: Button
    
    let button6: Button
    
    let button8: Button
  }
  
  let id: String
  
  let records: [Record]
}
