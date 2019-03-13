//
//  MissionSection.Respect+Gradient.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation
import UIKit

extension MissionSection.Respect {
  
  /// Creates `CAGradientLayer` matching each mission section.
  ///
  /// - Parameter direction: The direction of gradient layer.
  ///
  /// - Returns: The created `CAGradientLayer`.
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    let locations: [NSNumber] = [0, 0.5, 1]
    switch self {
    case .departure:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.137254902, green: 0.6549019608, blue: 0.3921568627, alpha: 1), #colorLiteral(red: 0.2431372549, green: 0.8235294118, blue: 0.8274509804, alpha: 1)],
                             locations: locations)
    case .clubRoad645:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.1568627451, green: 0.6431372549, blue: 0.7725490196, alpha: 1), #colorLiteral(red: 0.2352941176, green: 0.8235294118, blue: 0.8, alpha: 1)],
                             locations: locations)
    case .maxTheater:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.5176470588, green: 0.737254902, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 0.2941176471, green: 0.7137254902, blue: 0.9176470588, alpha: 1)],
                             locations: locations)
    case .anotherWorld:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.2156862745, green: 0.6392156863, blue: 0.7098039216, alpha: 1), #colorLiteral(red: 0.3215686275, green: 0.537254902, blue: 0.9333333333, alpha: 1)],
                             locations: locations)
    case .backStage:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.631372549, green: 0.4117647059, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.3450980392, green: 0.431372549, blue: 0.937254902, alpha: 1)],
                             locations: locations)
    case .chaosTheory:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.6705882353, green: 0.3254901961, blue: 0.7725490196, alpha: 1), #colorLiteral(red: 0.5294117647, green: 0.3647058824, blue: 0.9764705882, alpha: 1)],
                             locations: locations)
    case .soundLab:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.7098039216, green: 0.3294117647, blue: 0.8941176471, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.5529411765, blue: 0.3725490196, alpha: 1)],
                             locations: locations)
    case .visualizer:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.7294117647, green: 0.3137254902, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.4078431373, blue: 0.8156862745, alpha: 1)],
                             locations: locations)
    case .developers:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.6392156863, green: 0.2784313725, blue: 0.6901960784, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.4470588235, blue: 0.4392156863, alpha: 1)],
                             locations: locations)
    case .destination:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.5921568627, green: 0.2588235294, blue: 0.2588235294, alpha: 1), #colorLiteral(red: 0.6470588235, green: 0.06274509804, blue: 0.1803921569, alpha: 1)],
                             locations: locations)
    }
  }
}
