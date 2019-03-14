//
//  MissionSection.Technika2+Gradient.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

extension MissionSection.Technika2 {
  
  var color: UIColor? {
    switch self {
    case .starMixing: return .starMixing
    case .clubMixing: return .clubMixing
    }
  }
  
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    switch self {
    case .starMixing:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.537254902, green: 0.07058823529, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.1058823529, green: 0.3882352941, blue: 0.6392156863, alpha: 1), #colorLiteral(red: 0.2470588235, green: 0.6588235294, blue: 0.1921568627, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.7333333333, blue: 0.1843137255, alpha: 1)],
                             locations: [0, 0.25, 0.5, 0.75, 1])
    case .clubMixing:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.07843137255, green: 0.2470588235, blue: 0.6705882353, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.7960784314, blue: 0.1882352941, alpha: 1)],
                             locations: [0, 0.5, 1])
    }
  }
}
