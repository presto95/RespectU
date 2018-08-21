//
//  StringExtension.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 17..
//  Copyright © 2017년 Presto. All rights reserved.
//

import Foundation
import UIKit

extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var seriesColor: UIColor? {
        switch self {
        case Series.portable1:
            return UIColor.portable1
        case Series.portable2:
            return UIColor.portable2
        case Series.respect:
            return UIColor.respect
        case Series.trilogy:
            return UIColor.trilogy
        case Series.ce:
            return UIColor.ce
        case Series.technika1:
            return UIColor.technika1
        case Series.bs:
            return UIColor.bs
        default:
            return nil
        }
    }
    var missionColor: UIColor? {
        switch self {
        case Mission.Respect.departure:
            return #colorLiteral(red: 0.3058823529, green: 0.9058823529, blue: 0.7450980392, alpha: 1)
        case Mission.Respect.clubRoad645:
            return #colorLiteral(red: 0.337254902, green: 0.8470588235, blue: 0.9568627451, alpha: 1)
        case Mission.Respect.maxTheater:
            return #colorLiteral(red: 0.3098039216, green: 0.6980392157, blue: 0.9098039216, alpha: 1)
        case Mission.Respect.anotherWorld:
            return #colorLiteral(red: 0.4431372549, green: 0.5882352941, blue: 0.8705882353, alpha: 1)
        case Mission.Respect.backStage:
            return #colorLiteral(red: 0.7058823529, green: 0.6274509804, blue: 0.9215686275, alpha: 1)
        case Mission.Respect.chaosTheory:
            return #colorLiteral(red: 0.7019607843, green: 0.5490196078, blue: 0.8980392157, alpha: 1)
        case Mission.Respect.soundLab:
            return #colorLiteral(red: 0.831372549, green: 0.4705882353, blue: 0.937254902, alpha: 1)
        case Mission.Respect.visualizer:
            return #colorLiteral(red: 0.8941176471, green: 0.4745098039, blue: 0.9019607843, alpha: 1)
        case Mission.Respect.developers:
            return #colorLiteral(red: 0.9607843137, green: 0.3333333333, blue: 0.6549019608, alpha: 1)
        case Mission.Respect.destination:
            return #colorLiteral(red: 0.7960784314, green: 0.2862745098, blue: 0.3882352941, alpha: 1)
        case Mission.Trilogy.tSide:
            return #colorLiteral(red: 0.5607843137, green: 0.6784313725, blue: 0.831372549, alpha: 1)
        case Mission.Trilogy.rSide:
            return #colorLiteral(red: 0.662745098, green: 0.5803921569, blue: 0.8705882353, alpha: 1)
        case Mission.CE.electronicCity:
            return #colorLiteral(red: 0.8862745098, green: 0.8745098039, blue: 0.4431372549, alpha: 1)
        case Mission.CE.metropolis:
            return #colorLiteral(red: 0.7137254902, green: 0.631372549, blue: 0.8039215686, alpha: 1)
        case Mission.Technika1.platinumMixing:
            return #colorLiteral(red: 0.7137254902, green: 0.8196078431, blue: 0.8980392157, alpha: 1)
        case Mission.Technika1.technicalMixing:
            return #colorLiteral(red: 0.8901960784, green: 0.6, blue: 0.7803921569, alpha: 1)
        case Mission.BS.stylishPerformance:
            return #colorLiteral(red: 0.4980392157, green: 0.6274509804, blue: 0.8156862745, alpha: 1)
        case Mission.BS.absoluteSound:
            return #colorLiteral(red: 0.8039215686, green: 0.5019607843, blue: 0.6196078431, alpha: 1)
        case Mission.LinkDisk.whiteDisk:
            return #colorLiteral(red: 0.7058823529, green: 0.431372549, blue: 0.4745098039, alpha: 1)
        case Mission.LinkDisk.blackDisk:
            return #colorLiteral(red: 0.6392156863, green: 0.6, blue: 0.4196078431, alpha: 1)
        default:
            return nil
        }
    }
    var bpmToDouble: Double {
        if let notChangedBpm = Double(self) {
            return notChangedBpm
        } else {
            guard let lastBpm = self.split(separator: "~").last?.description else { return -1 }
            guard let changedBpm = Double(lastBpm.trimmingCharacters(in: .whitespaces)) else { return -1 }
            return changedBpm
        }
    }
    var noteAbbreviation: String? {
        if self == Note.none {
            return Note.none
        } else if self == Note.maxCombo {
            return "MC"
        } else if self == Note.perfectPlay {
            return "PP"
        } else {
            return nil
        }
    }
}


