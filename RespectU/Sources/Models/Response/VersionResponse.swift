//
//  VersionResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The response object about version.
struct VersionResponse: Codable {
  
  /// The client version.
  let clientVersion: String
  
  /// The server version.
  let serverVersion: String
  
  /// The ingame version.
  let gameVersion: String
}
