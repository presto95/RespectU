//
//  UITableViewCell+.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 6..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func setColorsInSong(_ series: String, labels: [UILabel]) {
        DispatchQueue.main.async { [weak self] in
            switch series {
            case Series.portable1:
                self?.contentView.backgroundColor = UIColor.portable1
                self?.setColors(of: labels, to: .white)
            case Series.portable2:
                self?.contentView.backgroundColor = UIColor.portable2
                self?.setColors(of: labels, to: .white)
            case Series.respect:
                self?.contentView.backgroundColor = UIColor.respect
                self?.setColors(of: labels, to: .white)
            case Series.trilogy:
                self?.contentView.backgroundColor = UIColor.trilogy
                self?.setColors(of: labels, to: .white)
            case Series.ce:
                self?.contentView.backgroundColor = UIColor.ce
                self?.setColors(of: labels, to: .black)
            case Series.technika1:
                self?.contentView.backgroundColor = UIColor.technika1
                self?.setColors(of: labels, to: .white)
            case Series.bs:
                self?.contentView.backgroundColor = UIColor.bs
                self?.setColors(of: labels, to: .white)
            default:
                break
            }
        }
    }
    
    func setColorsInMission(_ series: String, labels: [UILabel]) {
        DispatchQueue.main.async { [unowned self] in
            switch series {
            case MissionSection.respect.departure:
                self.contentView.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.9058823529, blue: 0.7450980392, alpha: 1)
            case MissionSection.respect.clubRoad645:
                self.contentView.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.8470588235, blue: 0.9568627451, alpha: 1)
            case MissionSection.respect.maxTheater:
                self.contentView.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.6980392157, blue: 0.9098039216, alpha: 1)
            case MissionSection.respect.anotherWorld:
                self.contentView.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.5882352941, blue: 0.8705882353, alpha: 1)
            case MissionSection.respect.backStage:
                self.contentView.backgroundColor = #colorLiteral(red: 0.7058823529, green: 0.6274509804, blue: 0.9215686275, alpha: 1)
            case MissionSection.respect.chaosTheory:
                self.contentView.backgroundColor = #colorLiteral(red: 0.7019607843, green: 0.5490196078, blue: 0.8980392157, alpha: 1)
            case MissionSection.respect.soundLab:
                self.contentView.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.4705882353, blue: 0.937254902, alpha: 1)
            case MissionSection.respect.visualizer:
                self.contentView.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.4745098039, blue: 0.9019607843, alpha: 1)
            case MissionSection.respect.developers:
                self.contentView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.3333333333, blue: 0.6549019608, alpha: 1)
            case MissionSection.respect.destination:
                self.contentView.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.2862745098, blue: 0.3882352941, alpha: 1)
            case MissionSection.trilogy.tSide:
                self.contentView.backgroundColor = #colorLiteral(red: 0.5607843137, green: 0.6784313725, blue: 0.831372549, alpha: 1)
            case MissionSection.trilogy.rSide:
                self.contentView.backgroundColor = #colorLiteral(red: 0.662745098, green: 0.5803921569, blue: 0.8705882353, alpha: 1)
            case MissionSection.ce.electronicCity:
                self.contentView.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.8745098039, blue: 0.4431372549, alpha: 1)
            case MissionSection.ce.metropolis:
                self.contentView.backgroundColor = #colorLiteral(red: 0.7137254902, green: 0.631372549, blue: 0.8039215686, alpha: 1)
            case MissionSection.technika1.platinumMixing:
                self.contentView.backgroundColor = #colorLiteral(red: 0.7137254902, green: 0.8196078431, blue: 0.8980392157, alpha: 1)
            case MissionSection.technika1.technicalMixing:
                self.contentView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.6, blue: 0.7803921569, alpha: 1)
            case MissionSection.bs.stylishPerformance:
                self.contentView.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.6274509804, blue: 0.8156862745, alpha: 1)
            case MissionSection.bs.absoluteSound:
                self.contentView.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.5019607843, blue: 0.6196078431, alpha: 1)
            case MissionSection.linkdisk.whiteDisk:
                self.contentView.backgroundColor = #colorLiteral(red: 0.7058823529, green: 0.431372549, blue: 0.4745098039, alpha: 1)
            case MissionSection.linkdisk.blackDisk:
                self.contentView.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.6, blue: 0.4196078431, alpha: 1)
            default:
                self.contentView.backgroundColor = .clear
            }
            self.setColors(of: labels, to: .white)
        }
    }
    
    func unsetColors(labels: [UILabel]) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.backgroundColor = .sub
            self?.setColors(of: labels, to: .black)
        }
    }
    
    private func setColors(of labels: [UILabel], to color: UIColor) {
        for label in labels {
            label.textColor = color
        }
    }
}
