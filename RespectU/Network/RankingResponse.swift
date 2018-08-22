//
//  Ranking.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct RankingResponse: Codable {
    struct Ranking: Codable {
        let _id: String
        let uid: String
        let userId: String
        let button4: Double
        let button5: Double
        let button6: Double
        let button8: Double
        let perfectPlay: Int
        let createdAt: Double
        let updatedAt: Double
        var createdDate: Date {
            return Date(timeIntervalSince1970: createdAt)
        }
        var updatedDate: Date {
            return Date(timeIntervalSince1970: updatedAt)
        }
    }
    let ranking: [Ranking]
}
