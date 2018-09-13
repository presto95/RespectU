//
//  Network.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

class Network {
    static func get(_ urlPath: String, successHandler: ((Data) -> Void)?, errorHandler: ((Error) -> Void)?) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlPath) else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                errorHandler?(error)
                return
            }
            guard let data = data else { return }
            successHandler?(data)
        }
        task.resume()
    }
    
    static func post(_ urlPath: String, parameters: [String: Any], successHandler: ((Data, Int) -> Void)?, errorHandler: ((Error) -> Void)?) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlPath) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                errorHandler?(error)
                return
            }
            guard let data = data else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            successHandler?(data, statusCode)
        }
        task.resume()
    }
    
    static func upload(_ urlPath: String, data: Data, succesHandler: ((Data, Int) -> Void)?, errorHandler: ((Error) -> Void)?) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlPath) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.uploadTask(with: request, from: data) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return
            }
            //성공
        }
        task.resume()
    }
}
