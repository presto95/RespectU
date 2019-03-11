//
//  TrophyGrade.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

/// The `enum` that defines a grade of specific trophy.
enum TrophyGrade: String {
  
  /// PLATINUM.
  case platinum
  
  /// GOLD.
  case gold
  
  /// SILVER.
  case silver
  
  /// BRONZE.
  case bronze
  
  /// Accesses the image of each case.
  var image: AssetImageTypeAlias {
    switch self {
    case .platinum:
      return Asset.trophyPlatinum.image
    case .gold:
      return Asset.trophyGold.image
    case .silver:
      return Asset.trophySilver.image
    case .bronze:
      return Asset.trophyBronze.image
    }
  }
}
