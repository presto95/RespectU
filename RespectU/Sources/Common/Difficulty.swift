//
//  Difficulty.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

/// The `enum` that defines difficulty.
enum Difficulty: String {
  
  /// NORMAL.
  case normal
  
  /// HARD.
  case hard
  
  /// MAXIMUM.
  case maximum
  
  /// Only in mission - FX.
  case fx
  
  /// Only in mission - SPECIAL.
  case special
  
  /// Only in mission - REDESIGN.
  case redesign
  
  /// The all difficulties in normal mode.
  static let all: [Difficulty] = [.normal, .hard, .maximum]
}
