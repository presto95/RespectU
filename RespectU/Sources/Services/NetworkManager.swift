//
//  Network.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

/// The `protocol` for networking.
protocol NetworkManagerType: class {
  
  /// Requests networking to `url` using `GET` method.
  ///
  /// - Parameters:
  ///   - url:        The url string.
  ///   - completion: The completion handler.
  func get(_ url: String, completion: @escaping (Data?, Error?) -> Void)
  
  /// Requests networking to `url` using `POST` method.
  ///
  /// - Parameters:
  ///   - url:        The url string.
  ///   - parameters: The parameters for making http body.
  ///   - completion: The completion handler.
  func post(_ url: String,
            parameters: [String: Any],
            completion: @escaping (Data?, Int?, Error?) -> Void)
  
  /// Uploads `data` to `url`.
  ///
  /// - Parameters:
  ///   - data:       The data to uploading.
  ///   - url:        The url string.
  ///   - completion: The completion handler.
  func upload(_ data: Data, to url: String, completion: @escaping (Data?, Int?, Error?) -> Void)
}

/// The network manager conforming `NetworkManagerType`.
final class NetworkManager: NetworkManagerType {
  
  func get(_ url: String, completion: @escaping (Data?, Error?) -> Void) {
    let session = URLSession(configuration: .default)
    guard case let url? = URL(string: url) else { return }
    let task = session.dataTask(with: url) { data, _, error in
      completion(data, error)
      session.finishTasksAndInvalidate()
    }
    task.resume()
  }
  
  func post(_ url: String,
            parameters: [String: Any],
            completion: @escaping (Data?, Int?, Error?) -> Void) {
    let session = URLSession(configuration: .default)
    guard case let url? = URL(string: url) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard case let httpBody? = try? JSONSerialization.data(withJSONObject: parameters, options: [])
      else { return }
    request.httpBody = httpBody
    let task = session.dataTask(with: request) { data, response, error in
      let statusCode = (response as? HTTPURLResponse)?.statusCode
      completion(data, statusCode, error)
      session.finishTasksAndInvalidate()
    }
    task.resume()
  }
  
  func upload(_ data: Data, to url: String, completion: @escaping (Data?, Int?, Error?) -> Void) {
    let session = URLSession(configuration: .default)
    guard case let url? = URL(string: url) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = session.uploadTask(with: request, from: data) { data, response, error in
      let statusCode = (response as? HTTPURLResponse)?.statusCode
      completion(data, statusCode, error)
      session.finishTasksAndInvalidate()
    }
    task.resume()
  }
}
