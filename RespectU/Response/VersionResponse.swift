//
//  VersionResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct VersionResponse: Codable {
    let clientVersion: String
    let serverVersion: String
    let gameVersion: String
}
