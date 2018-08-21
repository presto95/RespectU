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
    static func rankingFetch() {
        Network.get("\(baseUrl)/ranking/fetch", successHandler: { (data) in
            do {
                let results = try JSONDecoder().decode(RankingResponse.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func rankingUpload(parameters: [String: Any]) {
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
