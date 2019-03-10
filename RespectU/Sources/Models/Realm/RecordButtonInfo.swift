//
//  RecordButtonInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about button information on a record.
final class RecordButtonInfo: Object {
  
  /// The information about 'normal' difficulty in the button of the record.
  @objc dynamic var normal: RecordDifficultyInfo?
  
  /// The information about 'hard' difficulty in the button of the record.
  @objc dynamic var hard: RecordDifficultyInfo?
  
  /// The information about 'maximum' difficulty in the button of the record.
  @objc dynamic var maximum: RecordDifficultyInfo?
  
  /// The skill point in the button of the record.
  @objc dynamic var skillPoint: Double = 0
  
  /// The difficulty using for calculating skill point in the button of the record.
  @objc dynamic var skillPointDifficulty: String = ""
  
  /// The note using for calculating skill point in the button of the record.
  @objc dynamic var skillPointNote: String = ""
  
  /// The rate using for calculating skill point in the button of the record.
  @objc dynamic var skillPointRate: Double = 0
}
