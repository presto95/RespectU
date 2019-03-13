//
//  Language.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 22..
//  Copyright © 2018년 Presto. All rights reserved.
//

/// The response object about language.
struct LanguageResponse: Codable {
  
  /// The english data.
  let english: String
  
  /// The korean data.
  let korean: String?
}
