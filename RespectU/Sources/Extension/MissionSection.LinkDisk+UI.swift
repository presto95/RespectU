//
//  MissionSection.LinkDisk+Gradient.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

extension MissionSection.LinkDisk {
  
  var color: UIColor? {
    switch self {
    case .whiteDisk: return .whiteDisk
    case .blackDisk: return .blackDisk
    }
  }
  
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    let locations: [NSNumber] = [0, 0.5, 1]
    switch self {
    case .whiteDisk:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.6549019608, green: 0.03529411765, blue: 0.06274509804, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.7960784314, blue: 0.8117647059, alpha: 1)],
                             locations: locations)
    case .blackDisk:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.1333333333, green: 0.1176470588, blue: 0.1098039216, alpha: 1), #colorLiteral(red: 0.5921568627, green: 0.5411764706, blue: 0.3843137255, alpha: 1)],
                             locations: locations)
    }
  }
}
