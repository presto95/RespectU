//
//  API.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

import SwiftKeychainWrapper

/// The `protocol` for api service.
protocol APIServiceType: class {
  
  /// The network manager for api requests.
  var networkManager: NetworkManagerType { get }
  
  /// The base url.
  static var baseURL: String { get }
  
  /// The base url.
  var baseURL: String { get }
  
  /// The json decoder.
  var jsonDecoder: JSONDecoder { get }
  
  /// Decodes `data` to `type`.
  ///
  /// If the decoding process has failed, the error throwed by the process is returned.
  /// If the data is `nil`, passed error is returned.
  ///
  /// - Parameters:
  ///   - type  : The type that the `data` has converted. It conforms to `Decodable` protocol.
  ///   - data  : The `Data` to be converted to `type`.
  ///   - error : The error.
  ///
  /// - Returns: The decoded object and error.
  func decode<T>(to type: T.Type, data: Data?, error: Error?) -> (T?, Error?) where T: Decodable
  
  /// Requests songs by `series`.
  ///
  /// If `series` is `nil`, it requests all songs.
  ///
  /// - Parameters:
  ///   - series:     The series filtering songs.
  ///   - completion: The completion handler.
  func requestSongs(bySeries series: Series?,
                    completion: @escaping (SongResponse?, Error?) -> Void)
  
  /// Requests missions by `series`.
  ///
  /// If `series` is `nil`, it requests all missions.
  ///
  /// - Parameters:
  ///   - series:     The series filtering missions.
  ///   - completion: The completion handler.
  func requestMissions(bySeries series: Series?,
                       completion: @escaping (MissionResponse?, Error?) -> Void)
  
  /// Requests trophies by `series`.
  ///
  /// If `series` is `nil`, it requests all trophies.
  ///
  /// - Parameters:
  ///   - series:     The series filtering trophies.
  ///   - completion: The completion handler.
  func requestTrophies(bySeries series: Series?,
                       completion: @escaping (TrophyResponse?, Error?) -> Void)
  
  /// Requests achievements by `type`.
  ///
  /// If `type` is `nil`, it requests all achievements.
  ///
  /// - Parameters:
  ///   - type:       The type filtering achievements.
  ///   - completion: The completion handler.
  func requestAchievements(byType type: AchievementType?,
                           completion: @escaping (AchievementResponse?, Error?) -> Void)
  
  /// Requests tips.
  ///
  /// - Parameter completion:  The completion handler.
  func requestTips(completion: @escaping (TipResponse?, Error?) -> Void)
  
  /// Requests sign in.
  ///
  /// - Parameters:
  ///   - id:         The id of an user.
  ///   - password:   The password of an user.
  ///   - completion: The completion handler.
  func requestSignIn(id: String, password: String, completion: @escaping (Int?, Error?) -> Void)
  
  /// Requests sign up.
  ///
  /// - Parameters:
  ///   - id:         The id of an user
  ///   - password:   The password of an user.
  ///   - nickname:   The nickname of an user.
  ///   - completion: The completion handler.
  func requestSignUp(id: String,
                     password: String,
                     nickname: String,
                     completion: @escaping (Int?, Error?) -> Void)
  
  /// Requests the version.
  ///
  /// - Parameter completion: The completion handler.
  func requestVersions(completion: @escaping (VersionResponse?, Error?) -> Void)
  
  /// Requests the nickname.
  ///
  /// - Parameter completin: The completion handler.
  func requestNickname(completion: @escaping (NicknameResponse?, Error?) -> Void)
  
  /// Uploads the nickname.
  ///
  /// - Parameters:
  ///   - id:         The id of the user.
  ///   - nickname:   The nickname of the user.
  ///   - completion: The completion handler.
  func uploadNickname(id: String, nickname: String, completion: @escaping (Int?, Error?) -> Void)
  
  /// Requests records.
  ///
  /// - Parameters:
  ///   - id:         The id of the user.
  ///   - completion: The completion handler.
  func requestRecords(id: String, completion: @escaping (RecordResponse?, Error?) -> Void)
  
  /// Uploads records.
  ///
  /// - Parameters:
  ///   - data:       The data contains the record information.
  ///   - completion: The completion handler.
  func uploadRecords(_ data: Data, completion: @escaping (Int?, Error?) -> Void)
  
  /// Requests rankings.
  ///
  /// - Parameter completion: The completion handler.
  func requestRankings(completion: @escaping (RankingResponse?, Error?) -> Void)
  
  /// Uploads the ranking.
  ///
  /// - Parameters:
  ///   - id:         The id of the user.
  ///   - nickname:   The nickname of the user.
  ///   - button4:    The 4B skill point of the user.
  ///   - button5:    The 5B skill point of the user.
  ///   - button6:    The 6B skill point of the user.
  ///   - button8:    The 8B skill point of the user.
  ///   - completion: The completion handler.
  func uploadRanking(id: String,
                     nickname: String,
                     button4: Double,
                     button5: Double,
                     button6: Double,
                     button8: Double,
                     completion: @escaping (Int?, Error?) -> Void)
}

// MARK: - APIType protocol default implementation

extension APIServiceType {
  
  var networkManager: NetworkManagerType {
    return NetworkManager()
  }
  
  var baseURL: String {
    return "http://13.209.166.210:3000"
    // return "http://localhost:3000"
  }
  
  static var baseURL: String {
    return "http://13.209.166.210:3000"
    // return "http://localhost:3000"
  }
  
  var jsonDecoder: JSONDecoder {
    return JSONDecoder()
  }
  
  func decode<T>(to type: T.Type, data: Data?, error: Error?) -> (T?, Error?) where T: Decodable {
    if case let data? = data {
      do {
        let decoded = try jsonDecoder.decode(type, from: data)
        return (decoded, nil)
      } catch {
        return (nil, error)
      }
    } else {
      return (nil, error)
    }
  }

}


/// The api service conforming `APIServiceType`.
final class APIService: APIServiceType { }
