//
//  API.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

class API {
    private static let baseUrl = "http://localhost:3000"
    private static let jsonDecoder = JSONDecoder()
}

//MARK:- Song
extension API {
    static func fetchSongs(of series: String = "") {
        Network.get("\(baseUrl)/songs/\(series)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(SongResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveSongs, object: nil, userInfo: ["songs": results])
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

//MARK:- Mission
extension API {
    static func fetchMissions(of series: String) {
        Network.get("\(baseUrl)/missions/\(series)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(MissionResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveMissions, object: nil, userInfo: ["missions": results])
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

//MARK:- Trophy
extension API {
    static func fetchTrophies(of series: String) {
        Network.get("\(baseUrl)/trophies/\(series)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(TrophyResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveTrophies, object: nil, userInfo: ["trophies": results])
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

//MARK:- Achievement
extension API {
    static func fetchAchievements(of type: String = "") {
        Network.get("\(baseUrl)/achievements/\(type)", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(AchievementResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveAchievements, object: nil, userInfo: ["achievements": results])
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

//MARK:- Tip
extension API {
    static func fetchTips() {
        Network.get("\(baseUrl)/tips", successHandler: { (data) in
            do {
                let results = try jsonDecoder.decode(TipResponse.self, from: data)
                NotificationCenter.default.post(name: .didReceiveTips, object: nil, userInfo: ["tips": results])
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
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
