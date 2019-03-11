//
//  SkillLevel.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The `enum` that defines constants about skill level.
enum SkillLevel: String, CaseIterable {
  
  /// BEGINNER.
  case beginner = "BEGINNER"
  
  /// AMATUER 4.
  case amateur4 = "AMATEUR Ⅳ"
  
  /// AMATUER 3.
  case amateur3 = "AMATEUR Ⅲ"
  
  /// AMATUER 2.
  case amateur2 = "AMATEUR Ⅱ"
  
  /// AMATUER 1.
  case amateur1 = "AMATEUR Ⅰ"
  
  /// SUB DJ 4.
  case subDj4 = "SUB DJ Ⅳ"
  
  /// SUB DJ 3.
  case subDj3 = "SUB DJ Ⅲ"
  
  /// SUB DJ 2.
  case subDj2 = "SUB DJ Ⅱ"
  
  /// SUB DJ 1.
  case subDj1 = "SUB DJ Ⅰ"
  
  /// MAIN DJ 4.
  case mainDj4 = "MAIN DJ Ⅳ"
  
  /// MAIN DJ 3.
  case mainDj3 = "MAIN DJ Ⅲ"
  
  /// MAIN DJ 2.
  case mainDj2 = "MAIN DJ Ⅱ"
  
  /// MAIN DJ 1.
  case mainDj1 = "MAIN DJ Ⅰ"
  
  /// POP DJ 4.
  case popDj4 = "POP DJ Ⅳ"
  
  /// POP DJ 3.
  case popDj3 = "POP DJ Ⅲ"
  
  /// POP DJ 2.
  case popDj2 = "POP DJ Ⅱ"
  
  /// POP DJ 1.
  case popDj1 = "POP DJ Ⅰ"
  
  /// PROFESSIONAL 4.
  case professional4 = "PROFESSIONAL Ⅳ"
  
  /// PROFESSIONAL 3.
  case professional3 = "PROFESSIONAL Ⅲ"
  
  /// PROFESSIONAL 2.
  case professional2 = "PROFESSIONAL Ⅱ"
  
  /// PROFESSIONAL 1.
  case professional1 = "PROFESSIONAL Ⅰ"
  
  /// MIX MASTER 3.
  case mixMaster3 = "MIX MASTER Ⅲ"
  
  /// MIX MASTER 2.
  case mixMaster2 = "MIX MASTER Ⅱ"
  
  /// MIX MASTER 1.
  case mixMaster1 = "MIX MASTER Ⅰ"
  
  /// SUPERSTAR 3.
  case superstar3 = "SUPERSTAR Ⅲ"
  
  /// SUPERSTAR 2.
  case superstar2 = "SUPERSTAR Ⅱ"
  
  /// SUPERSTAR 1.
  case superstar1 = "SUPERSTAR Ⅰ"
  
  /// DJMAX GRAND MASTER.
  case djmaxGrandMaster = "DJMAX GRAND MASTER"
  
  /// THE DJMAX.
  case theDjmax = "✨THE DJMAX"
  
  /// The skill levels of 4 button mode.
  static let button4SkillLevels: [SkillLevel] = [
    .beginner,
    .amateur4,
    .amateur3,
    .amateur2,
    .amateur1,
    .subDj4,
    .subDj3,
    .subDj2,
    .subDj1,
    .mainDj4,
    .mainDj3,
    .mainDj2,
    .mainDj1,
    .popDj4,
    .popDj3,
    .popDj2,
    .popDj1,
    .professional3,
    .professional2,
    .professional1,
    .mixMaster3,
    .mixMaster2,
    .mixMaster1,
    .superstar3,
    .superstar2,
    .superstar1,
    .djmaxGrandMaster,
    .theDjmax
  ]
  
  /// The skill levels of 5 button mode.
  static let button5SkillLevels: [SkillLevel] = [
    .beginner,
    .amateur4,
    .amateur3,
    .amateur2,
    .amateur1,
    .subDj4,
    .subDj3,
    .subDj2,
    .subDj1,
    .mainDj4,
    .mainDj3,
    .mainDj2,
    .mainDj1,
    .popDj4,
    .popDj3,
    .popDj2,
    .popDj1,
    .professional3,
    .professional2,
    .professional1,
    .mixMaster3,
    .mixMaster2,
    .mixMaster1,
    .superstar3,
    .superstar2,
    .superstar1,
    .djmaxGrandMaster,
    .theDjmax
  ]
  
  /// The skill levels of 6 and 8 button mode.
  static let button6And8SkillLevels: [SkillLevel] = [
    .beginner,
    .amateur4,
    .amateur3,
    .amateur2,
    .amateur1,
    .subDj4,
    .subDj3,
    .subDj2,
    .subDj1,
    .mainDj4,
    .mainDj3,
    .mainDj2,
    .mainDj1,
    .popDj4,
    .popDj3,
    .popDj2,
    .popDj1,
    .professional4,
    .professional3,
    .professional2,
    .professional1,
    .mixMaster3,
    .mixMaster2,
    .mixMaster1,
    .superstar3,
    .superstar2,
    .superstar1,
    .djmaxGrandMaster,
    .theDjmax
  ]
}
