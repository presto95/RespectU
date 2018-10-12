//
//  StringExtension.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 17..
//  Copyright © 2017년 Presto. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var seriesGradientVertical: CAGradientLayer? {
        switch self {
        case Series.portable1:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.1215686275, green: 0.7098039216, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.7254901961, green: 0.2823529412, blue: 0.9764705882, alpha: 1)], locations: [0, 0.5, 1])
        case Series.portable2:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.9882352941, green: 0.1254901961, blue: 0.2784313725, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.2156862745, blue: 0.6705882353, alpha: 1)], locations: [0, 0.5, 1])
        case Series.respect:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.9607843137, green: 0.6745098039, blue: 0.1647058824, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0.4941176471, alpha: 1)], locations: [0, 0.5, 1])
        case Series.trilogy:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.3176470588, green: 0.4784313725, blue: 0.9725490196, alpha: 1), #colorLiteral(red: 0.3803921569, green: 0.9019607843, blue: 0.9725490196, alpha: 1)], locations: [0, 0.5, 1])
        case Series.ce:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9568627451, green: 0.831372549, blue: 0.3254901961, alpha: 1), #colorLiteral(red: 0.6039215686, green: 0.4941176471, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.7764705882, green: 0.5921568627, blue: 0.2509803922, alpha: 1)], locations: [0, 0.7, 0.8, 0.9, 1])
        case Series.technika1:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.5019607843, green: 0.4, blue: 0.8666666667, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.1058823529, blue: 0.5921568627, alpha: 1)], locations: [0, 0.5, 1])
        case Series.bs:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.8941176471, green: 0.06274509804, blue: 0.2901960784, alpha: 1), #colorLiteral(red: 0.4823529412, green: 0.09803921569, blue: 0.168627451, alpha: 1)], locations: [0, 0.5, 1])
        case Series.technika2:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.9647058824, green: 0.1411764706, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.4235294118, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.768627451, blue: 0.1764705882, alpha: 1), #colorLiteral(red: 0.337254902, green: 0.8156862745, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.1411764706, green: 0.8274509804, blue: 0.9921568627, alpha: 1)], locations: [0, 0.2, 0.4, 0.6, 0.8, 1])
        default:
            return nil
        }
    }
    
    var seriesColor: UIColor? {
        switch self {
        case Series.portable1:
            return .portable1
        case Series.portable2:
            return .portable2
        case Series.respect:
            return .respect
        case Series.trilogy:
            return .trilogy
        case Series.ce:
            return .ce
        case Series.technika1:
            return .technika1
        case Series.bs:
            return .bs
        case Series.technika2:
            return .technika2
        default:
            return nil
        }
    }
    
    var missionGradientVertical: CAGradientLayer? {
        switch self {
        case MissionSection.Respect.departure:
            return nil
        case MissionSection.Respect.clubRoad645:
            return nil
        case MissionSection.Respect.maxTheater:
            return nil
        case MissionSection.Respect.anotherWorld:
            return nil
        case MissionSection.Respect.backStage:
            return nil
        case MissionSection.Respect.chaosTheory:
            return nil
        case MissionSection.Respect.soundLab:
            return nil
        case MissionSection.Respect.visualizer:
            return nil
        case MissionSection.Respect.developers:
            return nil
        case MissionSection.Respect.destination:
            return nil
        case MissionSection.Trilogy.tSide:
            return nil
        case MissionSection.Trilogy.rSide:
            return nil
        case MissionSection.CE.electronicCity:
            return nil
        case MissionSection.CE.metropolis:
            return nil
        case MissionSection.Technika1.platinumMixing:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.09803921569, green: 0.1882352941, blue: 0.2980392157, alpha: 1), #colorLiteral(red: 0.5490196078, green: 0.6862745098, blue: 0.7921568627, alpha: 1)], locations: [0, 0.5, 1])
        case MissionSection.Technika1.technicalMixing:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.4, green: 0.07450980392, blue: 0.3803921569, alpha: 1), #colorLiteral(red: 0.8705882353, green: 0.2039215686, blue: 0.6392156863, alpha: 1)], locations: [0, 0.5, 1])
        case MissionSection.BS.stylishPerformance:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.3411764706, green: 0.6274509804, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.09803921569, green: 0.262745098, blue: 0.6784313725, alpha: 1)], locations: [0, 0.5, 1])
        case MissionSection.BS.absoluteSound:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.8588235294, green: 0.2078431373, blue: 0.5960784314, alpha: 1), #colorLiteral(red: 0.3960784314, green: 0.05490196078, blue: 0.1960784314, alpha: 1)], locations: [0, 0.5, 1])
        case MissionSection.LinkDisk.whiteDisk:
            return nil
        case MissionSection.LinkDisk.blackDisk:
            return nil
        case MissionSection.Technika2.popMixing:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.537254902, green: 0.07058823529, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.1058823529, green: 0.3882352941, blue: 0.6392156863, alpha: 1), #colorLiteral(red: 0.2470588235, green: 0.6588235294, blue: 0.1921568627, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.7333333333, blue: 0.1843137255, alpha: 1)], locations: [0, 0.25, 0.5, 0.75, 1])
        case MissionSection.Technika2.clubMixing:
            return CAGradientLayer.makeGradient(startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [#colorLiteral(red: 0.07843137255, green: 0.2470588235, blue: 0.6705882353, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.7960784314, blue: 0.1882352941, alpha: 1)], locations: [0, 0.5, 1])
        default:
            return nil
        }
    }
    
    var missionColor: UIColor? {
        switch self {
        case MissionSection.Respect.departure:
            return #colorLiteral(red: 0.3058823529, green: 0.9058823529, blue: 0.7450980392, alpha: 1)
        case MissionSection.Respect.clubRoad645:
            return #colorLiteral(red: 0.337254902, green: 0.8470588235, blue: 0.9568627451, alpha: 1)
        case MissionSection.Respect.maxTheater:
            return #colorLiteral(red: 0.3098039216, green: 0.6980392157, blue: 0.9098039216, alpha: 1)
        case MissionSection.Respect.anotherWorld:
            return #colorLiteral(red: 0.4431372549, green: 0.5882352941, blue: 0.8705882353, alpha: 1)
        case MissionSection.Respect.backStage:
            return #colorLiteral(red: 0.7058823529, green: 0.6274509804, blue: 0.9215686275, alpha: 1)
        case MissionSection.Respect.chaosTheory:
            return #colorLiteral(red: 0.7019607843, green: 0.5490196078, blue: 0.8980392157, alpha: 1)
        case MissionSection.Respect.soundLab:
            return #colorLiteral(red: 0.831372549, green: 0.4705882353, blue: 0.937254902, alpha: 1)
        case MissionSection.Respect.visualizer:
            return #colorLiteral(red: 0.8941176471, green: 0.4745098039, blue: 0.9019607843, alpha: 1)
        case MissionSection.Respect.developers:
            return #colorLiteral(red: 0.9607843137, green: 0.3333333333, blue: 0.6549019608, alpha: 1)
        case MissionSection.Respect.destination:
            return #colorLiteral(red: 0.7960784314, green: 0.2862745098, blue: 0.3882352941, alpha: 1)
        case MissionSection.Trilogy.tSide:
            return #colorLiteral(red: 0.5607843137, green: 0.6784313725, blue: 0.831372549, alpha: 1)
        case MissionSection.Trilogy.rSide:
            return #colorLiteral(red: 0.662745098, green: 0.5803921569, blue: 0.8705882353, alpha: 1)
        case MissionSection.CE.electronicCity:
            return #colorLiteral(red: 0.8862745098, green: 0.8745098039, blue: 0.4431372549, alpha: 1)
        case MissionSection.CE.metropolis:
            return #colorLiteral(red: 0.7137254902, green: 0.631372549, blue: 0.8039215686, alpha: 1)
        case MissionSection.Technika1.platinumMixing:
            return #colorLiteral(red: 0.7137254902, green: 0.8196078431, blue: 0.8980392157, alpha: 1)
        case MissionSection.Technika1.technicalMixing:
            return #colorLiteral(red: 0.8901960784, green: 0.6, blue: 0.7803921569, alpha: 1)
        case MissionSection.BS.stylishPerformance:
            return #colorLiteral(red: 0.4980392157, green: 0.6274509804, blue: 0.8156862745, alpha: 1)
        case MissionSection.BS.absoluteSound:
            return #colorLiteral(red: 0.8039215686, green: 0.5019607843, blue: 0.6196078431, alpha: 1)
        case MissionSection.LinkDisk.whiteDisk:
            return #colorLiteral(red: 0.7058823529, green: 0.431372549, blue: 0.4745098039, alpha: 1)
        case MissionSection.LinkDisk.blackDisk:
            return #colorLiteral(red: 0.6392156863, green: 0.6, blue: 0.4196078431, alpha: 1)
        case MissionSection.Technika2.popMixing:
            return #colorLiteral(red: 0.7803921569, green: 0.6980392157, blue: 0.3647058824, alpha: 1)
        case MissionSection.Technika2.clubMixing:
            return #colorLiteral(red: 0.7803921569, green: 0.6980392157, blue: 0.3647058824, alpha: 1)
        default:
            return nil
        }
    }

    var noteExpansion: String? {
        if self == Note.none {
            return Note.none
        } else if self == Note.maxCombo {
            return "MAX COMBO"
        } else if self == Note.perfectPlay {
            return "PERFECT PLAY"
        } else {
            return nil
        }
    }
    
    var noteAbbreviation: String {
        if self == "PERFECT PLAY" {
            return Note.perfectPlay
        } else if self == "MAX COMBO" {
            return Note.maxCombo
        } else {
            return ""
        }
    }
    
    var buttonExpansion: String? {
        switch self {
        case Buttons.button4:
            return "button4"
        case Buttons.button5:
            return "button5"
        case Buttons.button6:
            return "button6"
        case Buttons.button8:
            return "button8"
        default:
            return nil
        }
    }
    
    var rateConvertToDouble: Double {
        if let value = self.split(separator: "%").first?.description {
            return Double(value) ?? 0
        }
        return 0
    }
}
