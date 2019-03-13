//
//  Series+UI.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

extension Series {
  
  /// The color of each series.
  var color: UIColor? {
    switch self {
    case .portable1:
      return Asset.portable1.color
    case .portable2:
      return Asset.portable2.color
    case .respect:
      return Asset.respect.color
    case .trilogy:
      return Asset.trilogy.color
    case .ce:
      return Asset.ce.color
    case .technika1:
      return Asset.technika1.color
    case .bs:
      return Asset.bs.color
    case .technika2:
      return Asset.technika2.color
    case .technika3:
      return Asset.technika3.color
    case .linkdisk:
      return nil
    }
  }
  
  /// Creates `CAGradientLayer` matching each series in `direction`.
  ///
  /// - Parameter direction: The direction of the created gradient layer.
  ///
  /// - Returns: The created `CAGradientLayer`.
  func makeGradient(by direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction.startPoint
    let endPoint = direction.endPoint
    switch self {
    case .portable1:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.1215686275, green: 0.7098039216, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.7254901961, green: 0.2823529412, blue: 0.9764705882, alpha: 1)],
                             locations: [0, 0.5, 1])
    case .portable2:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.9882352941, green: 0.1254901961, blue: 0.2784313725, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.2156862745, blue: 0.6705882353, alpha: 1)],
                             locations: [0, 0.5, 1])
    case .respect:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.9607843137, green: 0.6745098039, blue: 0.1647058824, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0.4941176471, alpha: 1)],
                             locations: [0, 0.5, 1])
    case .trilogy:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.3176470588, green: 0.4784313725, blue: 0.9725490196, alpha: 1), #colorLiteral(red: 0.3803921569, green: 0.9019607843, blue: 0.9725490196, alpha: 1)],
                             locations: [0, 0.5, 1])
    case .ce:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9568627451, green: 0.831372549, blue: 0.3254901961, alpha: 1), #colorLiteral(red: 0.6039215686, green: 0.4941176471, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.7764705882, green: 0.5921568627, blue: 0.2509803922, alpha: 1)],
                             locations: [0, 0.7, 0.8, 0.9, 1])
    case .technika1:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.5019607843, green: 0.4, blue: 0.8666666667, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.1058823529, blue: 0.5921568627, alpha: 1)],
                             locations: [0, 0.5, 1])
    case .bs:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.8941176471, green: 0.06274509804, blue: 0.2901960784, alpha: 1), #colorLiteral(red: 0.4823529412, green: 0.09803921569, blue: 0.168627451, alpha: 1)],
                             locations: [0, 0.5, 1])
    case .technika2:
      return CAGradientLayer(startPoint: startPoint,
                             endPoint: endPoint,
                             colors: [#colorLiteral(red: 0.9647058824, green: 0.1411764706, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.4235294118, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.768627451, blue: 0.1764705882, alpha: 1), #colorLiteral(red: 0.337254902, green: 0.8156862745, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.1411764706, green: 0.8274509804, blue: 0.9921568627, alpha: 1)],
                             locations: [0, 0.2, 0.4, 0.6, 0.8, 1])
    case .technika3:
      return nil
    case .linkdisk:
      return nil
    }
  }
}
