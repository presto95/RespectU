//
//  TrophyResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct TrophyResponse: Codable {
    struct Trophy: Codable {
        let series: String
        let rating: String
        let image: String
        let title: Language
        let content: Language
    }
    let trophy: [Trophy]
    var count: Int {
        return trophy.count
    }
    subscript(index: Int) -> Trophy {
        return trophy[index]
    }
}
