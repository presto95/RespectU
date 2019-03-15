//
//  Mission.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The `protocol` that defines mission section type.
protocol MissionSectionType {
  
  /// The color representing each section.
  var color: UIColor? { get }
  
  /// Creates gradient layer by `direction`.
  ///
  /// - Parameter direction: The direction of the gradient layer.
  ///
  /// - Returns: The created gradient layer.
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer?
}

/// The `enum` that defines each mission sections.
enum MissionSection {
  
  /// The `enum` that defines RESPECT mission sections.
  enum Respect: String, MissionSectionType {
    
    /// RESPECT - Departure.
    case departure = "Departure"
    
    /// RESPECT - CLUB Road645.
    case clubRoad645 = "CLUB Road645"
    
    /// RESPECT - MAX Theater.
    case maxTheater = "MAX Theater"
    
    /// RESPECT - Another WORLD.
    case anotherWorld = "Another WORLD"
    
    /// RESPECT - Back STAGE.
    case backStage = "Back STAGE"
    
    /// RESPECT - Chaos theory.
    case chaosTheory = "Chaos theory"
    
    /// RESPECT - Sound Lab.
    case soundLab = "Sound Lab"
    
    /// RESPECT - Visualizer.
    case visualizer = "Visualizer"
    
    /// RESPECT - D-VELOPERS.
    case developers = "D-VELOPERS"
    
    /// RESPECT - Destination.
    case destination = "Destination"
  }
  
  /// The `enum` that defines TRILOGY mission sections.
  enum Trilogy: String, MissionSectionType {
    
    /// TRILOGY - T-SIDE.
    case tSide = "T-SIDE"
    
    /// TRILOGY - R-SIDE.
    case rSide = "R-SIDE"
  }
  
  /// The `enum` that defines CLAZZIQUAI EDITION mission sections.
  enum CE: String, MissionSectionType {
    
    /// CE - Electronic City.
    case electronicCity = "Electronic City"
    
    /// CE - Metropolis.
    case metropolis = "Metropolis"
  }
  
  /// The `enum` that defines TECHNIKA 1 mission sections.
  enum Technika1: String, MissionSectionType {
    
    /// TECHNIKA 1 - Platinum Mixing.
    case platinumMixing = "Platinum Mixing"
    
    /// TECHNIKA 1 - Technical Mixing.
    case technicalMixing = "Technical Mixing"
  }
  
  /// The `enum` that defines BLACK SQUARE mission sections.
  enum BS: String, MissionSectionType {
    
    /// BS - Stylish Performance.
    case stylishPerformance = "Stylish Performance"
    
    /// BS - Absolute Sound.
    case absoluteSound = "Absolute Sound"
  }
  
  /// The `enum` that defines TECHNIKA 2 mission sections.
  enum Technika2: String, MissionSectionType {
    
    /// TECHNIKA 2 - STAR MIXING.
    case starMixing = "STAR MIXING"
    
    /// TECHNIKA 2 - CLUB MIXING.
    case clubMixing = "CLUB MIXING"
  }
  
  /// The `enum` that defines LINK DISK mission sections.
  enum LinkDisk: String, MissionSectionType {
    
    /// LINK DISK - WHITE DISK.
    case whiteDisk = "WHITE DISK"
    
    /// LINK DISK - BLACK DISK.
    case blackDisk = "BLACK DISK"
  }
  
  /// The `enum` that defines TECHNIKA 3 mission sections.
  enum Technika3: String, MissionSectionType {
    
    /// TECHNIKA 3 - POP MIXING.
    case popMixing = "POP MIXING"
    
    /// TECHNIKA 3 - Crew Challenge.
    case crewChallenge = "Crew Challenge"
  }
  
  /// Creates section by `series` and `section`.
  ///
  /// - Parameters:
  ///   - series:   The series of the mission.
  ///   - section:  The section string value of the mission.
  ///
  ///  - Returns: The object conforming `MissionSectionType`. It can be `nil`.
  static func makeSection(bySeries series: Series, section: String) -> MissionSectionType? {
    switch series {
    case .respect:
      return MissionSection.Respect(rawValue: section)
    case .trilogy:
      return MissionSection.Trilogy(rawValue: section)
    case .ce:
      return MissionSection.CE(rawValue: section)
    case .technika1:
      return MissionSection.Technika1(rawValue: section)
    case .bs:
      return MissionSection.BS(rawValue: section)
    case .linkdisk:
      return MissionSection.LinkDisk(rawValue: section)
    case .technika2:
      return MissionSection.Technika2(rawValue: section)
    case .technika3:
      return MissionSection.Technika3(rawValue: section)
    default:
      return nil
    }
  }
}
