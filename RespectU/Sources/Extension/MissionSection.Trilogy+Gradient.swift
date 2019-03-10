//
//  MissionSection.Trilogy+Gradient.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation
import UIKit

extension MissionSection.Trilogy {
  
  /// Creates `CAGradientLayer` matching each mission section.
  ///
  /// - Parameter direction: The direction of gradient layer.
  ///
  /// - Returns: The created `CAGradientLayer`.
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    switch self {
    case .tSide:
      return CAGradientLayer.make(startPoint: startPoint,
                                          endPoint: endPoint,
                                          colors: [#colorLiteral(red: 0.2980392157, green: 0.337254902, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.4, green: 0.6980392157, blue: 0.9764705882, alpha: 1)],
                                          locations: [0, 0.5, 1])
    case .rSide:
      return CAGradientLayer.make(startPoint: startPoint,
                                          endPoint: endPoint,
                                          colors: [#colorLiteral(red: 0.2941176471, green: 0.337254902, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.5882352941, green: 0.4352941176, blue: 0.9568627451, alpha: 1)],
                                          locations: [0, 0.5, 1])
      
    }
  }
}
