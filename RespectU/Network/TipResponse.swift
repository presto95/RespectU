//
//  TipResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct TipResponse: Codable {
    struct Tip: Codable {
        let _id: String
        let title: String
        var koreanTitle: String {
            return title.localized
        }
    }
    let tip: [Tip]
}
