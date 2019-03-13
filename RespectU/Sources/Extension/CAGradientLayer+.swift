//
//  CAGradientLayer+.swift
//  RespectU
//
//  Created by Presto on 13/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

extension CAGradientLayer {
  
  /// Creates gradient layer.
  ///
  /// - Parameters:
  ///   - startPoint: The start point of a gradient layer.
  ///   - endPoint:   The end point of a gradient layer.
  ///   - colors:     The colors of a gradient layer.
  ///   - locations:  The locations of a gradient layer.
  ///
  /// - Returns: The gradient layer.
//  static func make(startPoint: CGPoint,
//                   endPoint: CGPoint,
//                   colors: [CGColor],
//                   locations: [NSNumber]) -> CAGradientLayer {
//    let gradient = CAGradientLayer()
//    gradient.startPoint = startPoint
//    gradient.endPoint = endPoint
//    gradient.colors = colors
//    gradient.locations = locations
//    return gradient
//  }
  
  /// Initializes the gradient layer.
  ///
  /// - Parameters:
  ///   - startPoint: The start point of a gradient layer.
  ///   - endPoint:   The end point of a gradient layer.
  ///   - colors:     The colors of a gradient layer.
  ///   - locations:  The locations of a gradient layer.
  convenience init(startPoint: CGPoint,
                   endPoint: CGPoint,
                   colors: [CGColor],
                   locations: [NSNumber]) {
    self.init()
    self.startPoint = startPoint
    self.endPoint = endPoint
    self.colors = colors
    self.locations = locations
  }
}
