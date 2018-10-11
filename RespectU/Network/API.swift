//
//  API.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class API {
    static let baseURL = "http://13.209.166.210:3000"
    //static let baseURL = "http://localhost:3000"
    private static let jsonDecoder = JSONDecoder()
}
// MARK: - Song
extension API {
    static func requestSongs(of series: String = "", completion: @escaping (SongResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/songs/\(series)", successHandler: { data in
            do {
                let decoded = try jsonDecoder.decode(SongResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveSongs, object: nil, userInfo: ["songs": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveSongs, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveSongs, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Mission
extension API {
    static func requestMissions(of series: String = "", completion: @escaping (MissionResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/missions/\(series)", successHandler: { data in
            do {
                let decoded = try jsonDecoder.decode(MissionResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveMissions, object: nil, userInfo: ["missions": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveMissions, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveMissions, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}

// MARK: - Trophy
extension API {
    static func requestTrophies(of series: String = "", completion: @escaping (TrophyResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/trophies/\(series)", successHandler: { data in
            do {
                let decoded = try jsonDecoder.decode(TrophyResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveTrophies, object: nil, userInfo: ["trophies": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveTrophies, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveTrophies, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Achievement
extension API {
    static func requestAchievements(of type: String = "", completion: @escaping (AchievementResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/achievements/\(type)", successHandler: { data in
            do {
                let decoded = try jsonDecoder.decode(AchievementResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveAchievements, object: nil, userInfo: ["achievements": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveAchievements, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveAchievements, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Tip
extension API {
    static func requestTips(completion: @escaping (TipResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/tips", successHandler: { data in
            do {
                let decoded = try jsonDecoder.decode(TipResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveTips, object: nil, userInfo: ["tips": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveTips, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveTips, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Sign In
extension API {
    static func requestSignIn(id: String, password: String, completion: @escaping (Int?, Error?) -> Void) {
        let parameters = ["id": id, "password": password]
        Network.post("\(baseURL)/users/signin", parameters: parameters, successHandler: { (_, statusCode) in
            completion(statusCode, nil)
            //NotificationCenter.default.post(name: .didReceiveSignIn, object: nil, userInfo: ["statusCode": statusCode])
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveSignIn, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Sign Up
extension API {
    static func requestSignUp(id: String, password: String, nickname: String, completion: @escaping (Int?, Error?) -> Void) {
        let parameters = ["id": id, "password": password, "nickname": nickname]
        Network.post("\(baseURL)/users/signup", parameters: parameters, successHandler: { (_, statusCode) in
            completion(statusCode, nil)
            //NotificationCenter.default.post(name: .didReceiveSignUp, object: nil, userInfo: ["statusCode": statusCode])
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveSignUp, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Version
extension API {
    static func requestVersions(completion: @escaping (VersionResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/version", successHandler: { (data) in
            do {
                let decoded = try jsonDecoder.decode(VersionResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveVersions, object: nil, userInfo: ["versions": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveVersions, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveVersions, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Nickname
extension API {
    static func requestNickname(completion: @escaping (NicknameResponse?, Error?) -> Void) {
        let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
        if id.isEmpty { return }
        Network.get("\(baseURL)/users/nickname/\(id)", successHandler: { data in
            do {
                let decoded = try jsonDecoder.decode(NicknameResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveNickname, object: nil, userInfo: ["nickname": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveNickname, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveNickname, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
    
    static func uploadNickname(id: String, nickname: String, completion: @escaping (Int?, Error?) -> Void) {
        let parameters = ["id": id, "nickname": nickname]
        Network.post("\(baseURL)/users/nickname", parameters: parameters, successHandler: { (_, statusCode) in
            completion(statusCode, nil)
            //NotificationCenter.default.post(name: .didReceiveUploadNickname, object: nil, userInfo: ["statusCode": statusCode])
            
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveUploadNickname, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Record
extension API {
    static func requestRecords(_ id: String, completion: @escaping (RecordResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/records/\(id)", successHandler: { (data) in
            do {
                let decoded = try jsonDecoder.decode(RecordResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveRequestRecords, object: nil, userInfo: ["records": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveRequestRecords, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveRequestRecords, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
    
    static func uploadRecords(_ object: Data, completion: @escaping (Int?, Error?) -> Void) {
        Network.upload("\(baseURL)/records", data: object, succesHandler: { (_, statusCode) in
            completion(statusCode, nil)
            //NotificationCenter.default.post(name: .didReceiveUploadRecords, object: nil, userInfo: ["statusCode": statusCode])
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveUploadRecords, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
// MARK: - Ranking
extension API {
    static func requestRankings(completion: (RankingResponse?, Error?) -> Void) {
        Network.get("\(baseURL)/rankings", successHandler: { (data) in
            do {
                let decoded = try jsonDecoder.decode(RankingResponse.self, from: data)
                completion(decoded, nil)
                //NotificationCenter.default.post(name: .didReceiveRankings, object: nil, userInfo: ["rankings": results])
            } catch {
                completion(nil, error)
                //NotificationCenter.default.post(name: .errorReceiveRankings, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveRankings, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
    
    static func uploadRanking(id: String, nickname: String, button4: Double, button5: Double, button6: Double, button8: Double, completion: @escaping (Int?, Error?) -> Void) {
        let parameters: [String: Any] = ["id": id, "nickname": nickname, "button4": button4, "button5": button5, "button6": button6, "button8": button8]
        Network.post("\(baseURL)/rankings", parameters: parameters, successHandler: { (_, statusCode) in
            completion(statusCode, nil)
            //NotificationCenter.default.post(name: .didReceiveUploadRanking, object: nil, userInfo: ["statusCode": statusCode])
        }, errorHandler: { error in
            completion(nil, error)
            //NotificationCenter.default.post(name: .errorReceiveUploadRanking, object: nil, userInfo: ["error": error.localizedDescription])
        })
    }
}
