//
//  MissionSection.CE+Gradient.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

extension MissionSection.CE {
  
  var color: UIColor? {
    switch self {
    case .electronicCity: return .electronicCity
    case .metropolis: return .metropolis
    }
  }
  
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    let locations: [NSNumber] = [0, 0.5, 1]
    switch self {
    case .electronicCity:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.2509803922, green: 0.2352941176, blue: 0.1960784314, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0.7254901961, blue: 0.2235294118, alpha: 1)],
                             locations: locations)
    case .metropolis:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.9254901961, green: 0.6980392157, blue: 0.2509803922, alpha: 1), #colorLiteral(red: 0.6274509804, green: 0.4784313725, blue: 0.7450980392, alpha: 1)],
                             locations: locations)
    }
  }
}
