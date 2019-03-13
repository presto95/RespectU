//
//  StringExtension.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 17..
//  Copyright © 2017년 Presto. All rights reserved.
//

import Foundation

extension String {
  
  /// The localized string.
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
  
  func missionGradient(_ direction: GradientDirection) -> CAGradientLayer? {
    let startPoint = direction == .horizontal ? CGPoint(x: 0, y: 0.5) : CGPoint(x: 0.5, y: 0)
    let endPoint = direction == .horizontal ? CGPoint(x: 1, y: 0.5) : CGPoint(x: 0.5, y: 1)
    switch self {
    case MissionSection.Respect.departure:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.137254902, green: 0.6549019608, blue: 0.3921568627, alpha: 1), #colorLiteral(red: 0.2431372549, green: 0.8235294118, blue: 0.8274509804, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.clubRoad645:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.1568627451, green: 0.6431372549, blue: 0.7725490196, alpha: 1), #colorLiteral(red: 0.2352941176, green: 0.8235294118, blue: 0.8, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.maxTheater:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.5176470588, green: 0.737254902, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 0.2941176471, green: 0.7137254902, blue: 0.9176470588, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.anotherWorld:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.2156862745, green: 0.6392156863, blue: 0.7098039216, alpha: 1), #colorLiteral(red: 0.3215686275, green: 0.537254902, blue: 0.9333333333, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.backStage:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.631372549, green: 0.4117647059, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.3450980392, green: 0.431372549, blue: 0.937254902, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.chaosTheory:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.6705882353, green: 0.3254901961, blue: 0.7725490196, alpha: 1), #colorLiteral(red: 0.5294117647, green: 0.3647058824, blue: 0.9764705882, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.soundLab:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.7098039216, green: 0.3294117647, blue: 0.8941176471, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.5529411765, blue: 0.3725490196, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.visualizer:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.7294117647, green: 0.3137254902, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.4078431373, blue: 0.8156862745, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.developers:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.6392156863, green: 0.2784313725, blue: 0.6901960784, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.4470588235, blue: 0.4392156863, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Respect.destination:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.5921568627, green: 0.2588235294, blue: 0.2588235294, alpha: 1), #colorLiteral(red: 0.6470588235, green: 0.06274509804, blue: 0.1803921569, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Trilogy.tSide:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.2980392157, green: 0.337254902, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.4, green: 0.6980392157, blue: 0.9764705882, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Trilogy.rSide:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.2941176471, green: 0.337254902, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.5882352941, green: 0.4352941176, blue: 0.9568627451, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.CE.electronicCity:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.2509803922, green: 0.2352941176, blue: 0.1960784314, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0.7254901961, blue: 0.2235294118, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.CE.metropolis:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.9254901961, green: 0.6980392157, blue: 0.2509803922, alpha: 1), #colorLiteral(red: 0.6274509804, green: 0.4784313725, blue: 0.7450980392, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Technika1.platinumMixing:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.09803921569, green: 0.1882352941, blue: 0.2980392157, alpha: 1), #colorLiteral(red: 0.5490196078, green: 0.6862745098, blue: 0.7921568627, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Technika1.technicalMixing:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.4, green: 0.07450980392, blue: 0.3803921569, alpha: 1), #colorLiteral(red: 0.8705882353, green: 0.2039215686, blue: 0.6392156863, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.BS.stylishPerformance:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.3411764706, green: 0.6274509804, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.09803921569, green: 0.262745098, blue: 0.6784313725, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.BS.absoluteSound:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.8588235294, green: 0.2078431373, blue: 0.5960784314, alpha: 1), #colorLiteral(red: 0.3960784314, green: 0.05490196078, blue: 0.1960784314, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.LinkDisk.whiteDisk:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.6549019608, green: 0.03529411765, blue: 0.06274509804, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.7960784314, blue: 0.8117647059, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.LinkDisk.blackDisk:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.1333333333, green: 0.1176470588, blue: 0.1098039216, alpha: 1), #colorLiteral(red: 0.5921568627, green: 0.5411764706, blue: 0.3843137255, alpha: 1)], locations: [0, 0.5, 1])
    case MissionSection.Technika2.starMixing:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.537254902, green: 0.07058823529, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.1058823529, green: 0.3882352941, blue: 0.6392156863, alpha: 1), #colorLiteral(red: 0.2470588235, green: 0.6588235294, blue: 0.1921568627, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.7333333333, blue: 0.1843137255, alpha: 1)], locations: [0, 0.25, 0.5, 0.75, 1])
    case MissionSection.Technika2.clubMixing:
      return CAGradientLayer.makeGradient(startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.07843137255, green: 0.2470588235, blue: 0.6705882353, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.7960784314, blue: 0.1882352941, alpha: 1)], locations: [0, 0.5, 1])
    default:
      return nil
    }
  }
}
