//
//  MissionSection.Technika3+Gradient.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

extension MissionSection.Technika3 {
  
  var color: UIColor? {
    switch self {
    case .popMixing: return .popMixing
    case .crewChallenge: return .crewChallenge
    }
  }
  
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    let locations: [NSNumber] = [0, 0.5, 1]
    switch self {
    case .popMixing:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.1490196078, green: 0.2666666667, blue: 0.3882352941, alpha: 1), #colorLiteral(red: 0.768627451, green: 0.6235294118, blue: 0.8666666667, alpha: 1)],
                             locations: locations)
    case .crewChallenge:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.4039215686, alpha: 1), #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)],
                             locations: locations)
    }
  }
}
