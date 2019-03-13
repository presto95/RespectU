//
//  SongResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about song.
struct SongResponse: Codable {
  
  /// The song data in the song response object.
  struct Song: Codable {
    
    /// The button data in the song response object.
    struct Button: Codable {
      
      /// The normal difficulty value in the button of the song.
      let normal: Int
      
      /// The hard difficulty value in the button of the song.
      let hard: Int
      
      /// The maximum difficulty value in the button of the song.
      let maximum: Int
    }
    
    /// The title of the song.
    let title: LanguageResponse
    
    /// The lowercased title of the song.
    let lowercase: LanguageResponse
    
    /// The series of the song.
    let series: String
    
    /// The composer of the song.
    let composer: String
    
    /// The bpm of the song.
    let bpm: Int
    
    /// The sub bpm of the song.
    ///
    /// If this value is not nil, this song has variant bpm.
    /// In this case, `bpm` becomes the minimum bpm and `subBpm` becomes the maximum bpm.
    let subBpm: Int?
    
    /// The information about 4B of the song.
    let button4: Button
    
    /// The information about 5B of the song.
    let button5: Button
    
    /// The information about 6B of the song.
    let button6: Button
    
    /// The information about 8B of the song.
    let button8: Button
    
    /// The localized title of the song.
    var localizedTitle: String {
      if Locale.current.regionCode == "KR", let korean = title.korean {
        return korean
      } else {
        return title.english
      }
    }
    
    /// The localized lowercased title of the song.
    var localizedLowercase: String {
      if Locale.current.regionCode == "KR", let korean = lowercase.korean {
        return korean
      } else {
        return lowercase.english
      }
    }
    
    /// The string value conveted by `bpm` and `subBPM`.
    ///
    /// `bpm == 130, subBPM == nil` -> "BPM 130"
    /// `bpm == 130, subBPM == 153` -> "BPM 130 ~ 153"
    var bpmToString: String {
      if let subBpm = subBpm {
        return "BPM \(bpm) ~ \(subBpm)"
      } else {
        return "BPM \(bpm)"
      }
    }
  }
  
  /// The songs.
  let songs: [Song]
  
  /// The number of `songs`.
  var count: Int {
    return songs.count
  }
  
  /// Accesses the `index`th element in `songs`.
  subscript(index: Int) -> Song {
    return songs[index]
  }
}
