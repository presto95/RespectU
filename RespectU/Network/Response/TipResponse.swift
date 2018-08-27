//
//  TipResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct TipResponse: Codable {
    struct Tip: Codable {
        let title: Language
    }
    let tip: [Tip]
    var count: Int {
        return tip.count
    }
    subscript(index: Int) -> Tip {
        return tip[index]
    }
}
