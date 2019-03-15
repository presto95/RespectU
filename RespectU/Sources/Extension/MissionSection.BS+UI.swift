//
//  MissionSection.BS+Gradient.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

extension MissionSection.BS {
  
  var color: UIColor? {
    switch self {
    case .stylishPerformance: return .stylishPerformance
    case .absoluteSound: return .absoluteSound
    }
  }
  
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    let locations: [NSNumber] = [0, 0.5, 1]
    switch self {
    case .stylishPerformance:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.3411764706, green: 0.6274509804, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.09803921569, green: 0.262745098, blue: 0.6784313725, alpha: 1)],
                             locations: locations)
    case .absoluteSound:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.8588235294, green: 0.2078431373, blue: 0.5960784314, alpha: 1), #colorLiteral(red: 0.3960784314, green: 0.05490196078, blue: 0.1960784314, alpha: 1)],
                             locations: locations)
    }
  }
}
