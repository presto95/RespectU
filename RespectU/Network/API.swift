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
    static let baseURL = "http://localhost:3000"
    private static let jsonDecoder = JSONDecoder()
}

//MARK:- Song
extension API {
    static func requestSongs(of series: String = "") {
        Network.get("\(baseURL)/songs/\(series)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(SongResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveSongs, object: nil, userInfo: ["songs": results])
            } catch {
                NotificationCenter.default.post(name: .errorReceiveSongs, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveSongs, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Mission
extension API {
    static func requestMissions(of series: String = "") {
        Network.get("\(baseURL)/missions/\(series)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(MissionResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveMissions, object: nil, userInfo: ["missions": results])
            } catch {
                NotificationCenter.default.post(name: .errorReceiveMissions, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveMissions, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Trophy
extension API {
    static func requestTrophies(of series: String = "") {
        Network.get("\(baseURL)/trophies/\(series)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(TrophyResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveTrophies, object: nil, userInfo: ["trophies": results])
            } catch {
                NotificationCenter.default.post(name: .errorReceiveTrophies, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveTrophies, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Achievement
extension API {
    static func requestAchievements(of type: String = "") {
        Network.get("\(baseURL)/achievements/\(type)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(AchievementResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveAchievements, object: nil, userInfo: ["achievements": results])
            } catch {
                NotificationCenter.default.post(name: .errorReceiveAchievements, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveAchievements, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Tip
extension API {
    static func requestTips() {
        Network.get("\(baseURL)/tips", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(TipResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveTips, object: nil, userInfo: ["tips": results])
            } catch {
                NotificationCenter.default.post(name: .errorReceiveTips, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveTips, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Sign In
extension API {
    static func requestSignIn(id: String, password: String) {
        let parameters = ["id": id, "password": password]
        Network.post("\(baseURL)/users/signin", parameters: parameters, successHandler: { (data, statusCode) in
            NotificationCenter.default.post(name: .didReceiveSignIn, object: nil, userInfo: ["statusCode": statusCode])
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveSignIn, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Sign Up
extension API {
    static func requestSignUp(id: String, password: String, nickname: String) {
        let parameters = ["id": id, "password": password, "nickname": nickname]
        Network.post("\(baseURL)/users/signup", parameters: parameters, successHandler: { (data, statusCode) in
            NotificationCenter.default.post(name: .didReceiveSignUp, object: nil, userInfo: ["statusCode": statusCode])
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveSignUp, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Version
extension API {
    static func requestVersions() {
        Network.get("\(baseURL)/version", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(VersionResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveVersions, object: nil, userInfo: ["versions": results])
            } catch {
                NotificationCenter.default.post(name: .errorReceiveVersions, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveVersions, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Record
extension API {
    static func requestRecords() {
        guard let id = KeychainWrapper.standard.string(forKey: "id") else { return }
        Network.get("\(baseURL)/records/\(id)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(RecordResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveRequestRecords, object: nil, userInfo: ["records": results])
            } catch {
                NotificationCenter.default.post(name: .errorReceiveRequestRecords, object: nil, userInfo: ["error": error.localizedDescription])
            }
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveRequestRecords, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
    
    static func uploadRecords(_ object: NewRecordInfo) {
        let id = KeychainWrapper.standard.string(forKey: "id")
        let parameters: [String: Any] = [:
            
        ]
        Network.post("\(baseURL)/records", parameters: parameters, successHandler: { (data, statusCode) in
            NotificationCenter.default.post(name: .didReceiveUploadRecords, object: nil, userInfo: ["statusCode": statusCode])
        }) { (error) in
            NotificationCenter.default.post(name: .errorReceiveUploadRecords, object: nil, userInfo: ["error": error.localizedDescription])
        }
    }
}

//MARK:- Ranking
extension API {
    static func requestRankings() {
        Network.get("\(baseURL)/records", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(RankingResponse.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
