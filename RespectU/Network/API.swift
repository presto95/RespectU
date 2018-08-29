//
//  API.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

class API {
    static let baseUrl = "http://localhost:3000"
    private static let jsonDecoder = JSONDecoder()
}

//MARK:- Song
extension API {
    static func requestSongs(of series: String = "") {
        Network.get("\(baseUrl)/songs/\(series)", successHandler: { (data) in
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
    static func requestMissions(of series: String) {
        Network.get("\(baseUrl)/missions/\(series)", successHandler: { (data) in
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
    static func requestTrophies(of series: String) {
        Network.get("\(baseUrl)/trophies/\(series)", successHandler: { (data) in
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
        Network.get("\(baseUrl)/achievements/\(type)", successHandler: { (data) in
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
        Network.get("\(baseUrl)/tips", successHandler: { (data) in
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

//MARK:- Record
extension API {
    
}

//MARK:- Ranking
extension API {
    static func fetchRankings() {
        Network.get("\(baseUrl)/rankings/fetch", successHandler: { (data) in
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
    
    static func uploadRanking(parameters: [String: Any]) {
        Network.post("\(baseUrl)/ranking/upload", parameters: parameters, successHandler: { (data) in
            do {
                print(data)
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
