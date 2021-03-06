//
//  CAGradientLayer+.swift
//  RespectU
//
//  Created by Presto on 13/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

extension CAGradientLayer {
  
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
    self.do {
      $0.startPoint = startPoint
      $0.endPoint = endPoint
      $0.colors = colors
      $0.locations = locations
    }
  }
}
