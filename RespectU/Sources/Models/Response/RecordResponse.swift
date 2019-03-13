//
//  RecordResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about record.
struct RecordResponse: Codable {
  
  /// The record data in the record response object.
  struct Record: Codable {
    
    /// The button data in the record response object.
    struct Button: Codable {
      
      /// The difficulty data in the record response object.
      struct Difficulty: Codable {
        
        /// The rank in the difficulty in the button of the record.
        let rank: String
        
        /// The rate in the difficulty in the button of the record.
        let rate: Double
        
        /// The note in the difficulty in the button of the record.
        let note: String
      }
      
      /// The normal difficulty in the button of the record.
      let normal: Difficulty
      
      /// The hard difficulty in the button of the record.
      let hard: Difficulty
      
      /// The maximum difficulty in the button of the record.
      let maximum: Difficulty
      
      /// The skill point in the button of the record.
      let skillPoint: Double
      
      /// The difficulty using for calculating skill point in the button of the record.
      let skillPointDifficulty: String
      
      /// The note using for calculating skill point in the button of the record.
      let skillPointNote: String
      
      /// The rate using for calculating skill point in the button of the record.
      let skillPointRate: Double
    }
    
    /// The title of the record.
    let title: LanguageResponse
    
    /// The series of the record.
    let series: String
    
    /// The information about 4B of the record.
    let button4: Button
    
    /// The information about 5B of the record.
    let button5: Button
    
    /// The information about 6B of the record.
    let button6: Button
    
    /// The information about 8B of the record.
    let button8: Button
  }
  
  /// The user identifier.
  let id: String
  
  /// The records.
  let records: [Record]
}
