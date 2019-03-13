//
//  GradientDirection.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

/// The `enum` that defines a direction of gradient layer.
enum GradientDirection {
  
  /// Horizontal.
  case horizontal
  
  /// Vertical.
  case vertical
  
  /// The start point of gradient layer according to the direction.
  var startPoint: CGPoint {
    switch self {
    case .horizontal:
      return .init(x: 0, y: 0.5)
    case .vertical:
      return .init(x: 0.5, y: 0)
    }
  }
  
  /// The end point of gradient layer according to the direction.
  var endPoint: CGPoint {
    switch self {
    case .horizontal:
      return .init(x: 1, y: 0.5)
    case .vertical:
      return .init(x: 0.5, y: 1)
    }
  }
}
