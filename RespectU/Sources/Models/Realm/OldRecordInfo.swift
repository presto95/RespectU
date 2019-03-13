//
//  OldRecordInfo.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import RealmSwift

/// The realm object about record.
///
/// - Note: This is deprecated. It remains only for users using 2.x version.
@available (*, deprecated)
final class OldRecordInfo: Object {
  
  /// The series of the record.
  @objc dynamic var series: String = ""
  
  /// The titie of the record.
  @objc dynamic var title: String = ""

  /// The rank of 4B in normal difficulty of the record.
  @objc dynamic var nm4Rank: String = "-"
  
  /// The rate of 4B in normal difficulty of the record.
  @objc dynamic var nm4Rate: String = "-"
  
  /// The note of 4B in normal difficulty of the record.
  @objc dynamic var nm4Note: String = "-"
  
  /// The rank of 4B in hard difficulty of the record.
  @objc dynamic var hd4Rank: String = "-"
  
  /// The rate of 4B in hard difficulty of the record.
  @objc dynamic var hd4Rate: String = "-"
  
  /// The note of 4B in hard difficulty of the record.
  @objc dynamic var hd4Note: String = "-"
  
  /// The rank of 4B in maximum difficulty of the record.
  @objc dynamic var mx4Rank: String = "-"
  
  /// The rate of 4B in maximum difficulty of the record.
  @objc dynamic var mx4Rate: String = "-"
  
  /// The note of 4B in maximum difficulty of the record.
  @objc dynamic var mx4Note: String = "-"
  
  /// The rank of 5B in normal difficulty of the record.
  @objc dynamic var nm5Rank: String = "-"
  
  /// The rate of 5B in normal difficulty of the record.
  @objc dynamic var nm5Rate: String = "-"
  
  /// The note of 5B in normal difficulty of the record.
  @objc dynamic var nm5Note: String = "-"
  
  /// The rank of 5B in hard difficulty of the record.
  @objc dynamic var hd5Rank: String = "-"
  
  /// The rate of 5B in hard difficulty of the record.
  @objc dynamic var hd5Rate: String = "-"
  
  /// The note of 5B in hard difficulty of the record.
  @objc dynamic var hd5Note: String = "-"
  
  /// The rank of 5B in maximum difficulty of the record.
  @objc dynamic var mx5Rank: String = "-"
  
  /// The rate of 5B in maximum difficulty of the record.
  @objc dynamic var mx5Rate: String = "-"
  
  /// The note of 5B in maximum difficulty of the record.
  @objc dynamic var mx5Note: String = "-"
  
  /// The rank of 6B in normal difficulty of the record.
  @objc dynamic var nm6Rank: String = "-"
  
  /// The rate of 6B in normal difficulty of the record.
  @objc dynamic var nm6Rate: String = "-"
  
  /// The note of 6B in normal difficulty of the record.
  @objc dynamic var nm6Note: String = "-"
  
  /// The rank of 6B in hard difficulty of the record.
  @objc dynamic var hd6Rank: String = "-"
  
  /// The rate of 6B in hard difficulty of the record.
  @objc dynamic var hd6Rate: String = "-"
  
  /// The note of 6B in hard difficulty of the record.
  @objc dynamic var hd6Note: String = "-"
  
  /// The rank of 6B in maximum difficulty of the record.
  @objc dynamic var mx6Rank: String = "-"
  
  /// The rate of 6B in maximum difficulty of the record.
  @objc dynamic var mx6Rate: String = "-"
  
  /// The note of 6B in maximum difficulty of the record.
  @objc dynamic var mx6Note: String = "-"
  
  /// The rank of 8B in normal difficulty of the record.
  @objc dynamic var nm8Rank: String = "-"
  
  /// The rate of 8B in normal difficulty of the record.
  @objc dynamic var nm8Rate: String = "-"
  
  /// The note of 8B in normal difficulty of the record.
  @objc dynamic var nm8Note: String = "-"
  
  /// The rank of 8B in hard difficulty of the record.
  @objc dynamic var hd8Rank: String = "-"
  
  /// The rate of 8B in hard difficulty of the record.
  @objc dynamic var hd8Rate: String = "-"
  
  /// The note of 8B in hard difficulty of the record.
  @objc dynamic var hd8Note: String = "-"
  
  /// The rank of 8B in maximum difficulty of the record.
  @objc dynamic var mx8Rank: String = "-"
  
  /// The rate of 8B in maximum difficulty of the record.
  @objc dynamic var mx8Rate: String = "-"
  
  /// The note of 8B in maximum difficulty of the record.
  @objc dynamic var mx8Note: String = "-"
  
  /// The normal difficulty in 4B of the record.
  @objc dynamic var nm4: Int = 0
  
  /// The normal difficulty in 5B of the record.
  @objc dynamic var nm5: Int = 0
  
  /// The normal difficulty in 6B of the record.
  @objc dynamic var nm6: Int = 0
  
  /// The normal difficulty in 8B of the record.
  @objc dynamic var nm8: Int = 0
  
  /// The hard difficulty in 4B of the record.
  @objc dynamic var hd4: Int = 0
  
  /// The hard difficulty in 5B of the record.
  @objc dynamic var hd5: Int = 0
  
  /// The hard difficulty in 6B of the record.
  @objc dynamic var hd6: Int = 0
  
  /// The hard difficulty in 8B of the record.
  @objc dynamic var hd8: Int = 0
  
  /// The maximum difficulty in 4B of the record.
  @objc dynamic var mx4: Int = 0
  
  /// The maximum difficulty in 5B of the record.
  @objc dynamic var mx5: Int = 0
  
  /// The maximum difficulty in 6B of the record.
  @objc dynamic var mx6: Int = 0
  
  /// The maximum difficulty in 8B of the record.
  @objc dynamic var mx8: Int = 0
  
  /// The skill point in 4B of the record.
  @objc dynamic var button4SkillPoint: Double = 0.0
  
  /// The skill point in 5B of the record.
  @objc dynamic var button5SkillPoint: Double = 0.0
  
  /// The skill point in 6B of the record.
  @objc dynamic var button6SkillPoint: Double = 0.0
  
  /// The skill point in 8B of the record.
  @objc dynamic var button8SkillPoint: Double = 0.0
  
  /// The difficulty using for calculating the skill point in 4B of the record.
  @objc dynamic var button4HighestSkillPointDifficulty: String = ""
  
  /// The rate using for calculating the skill point in 4B of the record.
  @objc dynamic var button4HighestSkillPointRate: String = ""
  
  /// The note using for calculating the skill point in 4B of the record.
  @objc dynamic var button4HighestSkillPointNote: String = ""
  
  /// The difficulty using for calculating the skill point in 5B of the record.
  @objc dynamic var button5HighestSkillPointDifficulty: String = ""
  
  /// The rate using for calculating the skill point in 5B of the record.
  @objc dynamic var button5HighestSkillPointRate: String = ""
  
  /// The note using for calculating the skill point in 5B of the record.
  @objc dynamic var button5HighestSkillPointNote: String = ""
  
  /// The difficulty using for calculating the skill point in 6B of the record.
  @objc dynamic var button6HighestSkillPointDifficulty: String = ""
  
  /// The rate using for calculating the skill point in 6B of the record.
  @objc dynamic var button6HighestSkillPointRate: String = ""
  
  /// The note using for calculating the skill point in 6B of the record.
  @objc dynamic var button6HighestSkillPointNote: String = ""
  
  /// The difficulty using for calculating the skill point in 8B of the record.
  @objc dynamic var button8HighestSkillPointDifficulty: String = ""
  
  /// The rate using for calculating the skill point in 8B of the record.
  @objc dynamic var button8HighestSkillPointRate: String = ""
  
  /// The note using for calculating the skill point in 8B of the record.
  @objc dynamic var button8HighestSkillPointNote: String = ""
  
  /// The lowercased title.
  @objc dynamic var lowercase: String = ""
  
  /// Fetches all records.
  ///
  /// - Returns: Fetched records.
  static func get() -> Results<OldRecordInfo> {
    let oldConfig = Realm
      .Configuration(fileURL: Realm.Configuration
        .defaultConfiguration.fileURL!
        .deletingLastPathComponent()
        .appendingPathComponent("default.realm"),
                     schemaVersion: 13,
                     migrationBlock: { (_, oldVersion) in
                      if oldVersion < 1 {}
      })
    let result = try! Realm(configuration: oldConfig).objects(OldRecordInfo.self)
    return result
  }
}
