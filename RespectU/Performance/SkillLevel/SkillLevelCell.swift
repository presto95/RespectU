//
//  SkillPointCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import GaugeKit
import RealmSwift

protocol SkillLevelCellDelegate: class {
    func touchUpTop50Button(_ sender: UIButton)
    func touchUpRankingButton(_ sender: UIButton)
    func touchUpCalculatorButton(_ sender: UIButton)
}

class SkillLevelCell: UITableViewCell {

    weak var delegate: SkillLevelCellDelegate?
    @IBOutlet var gauge: Gauge!
    @IBOutlet weak var skillLevelLabel: UILabel!
    @IBOutlet weak var skillPointLabel: UILabel!
    @IBOutlet weak var top50Button: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var calculatorButton: UIButton!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var nextLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let buttons = [top50Button, rankingButton, calculatorButton]
        for button in buttons {
            button?.layer.borderColor = UIColor.main.cgColor
            button?.layer.borderWidth = 2
        }
        self.rankingButton.setTitle("Ranking".localized, for: .normal)
        self.calculatorButton.setTitle("Calculator".localized, for: .normal)
        self.top50Button.addTarget(self, action: #selector(touchUpTop50Button(_:)), for: .touchUpInside)
        self.rankingButton.addTarget(self, action: #selector(touchUpRankingButton(_:)), for: .touchUpInside)
        self.calculatorButton.addTarget(self, action: #selector(touchUpCalculatorButton(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ button: String, max: Double, myRecord: (sum: Double, highestSeries: String)) {
        let mySkillPointSum = myRecord.sum
        let myHighestSeries = myRecord.highestSeries
        let seriesColor = myHighestSeries.seriesColor ?? .clear
        self.gauge.maxValue = CGFloat(max)
        self.gauge.rate = CGFloat(mySkillPointSum)
        self.gauge.startColor = seriesColor
        self.gauge.bgColor = seriesColor
        self.skillPointLabel.text = "\((mySkillPointSum * 100).rounded() / 100) " + "Point".localized
        self.skillLevelLabel.text = {
            switch button {
            case Buttons.button4:
                return Skill.button4SkillLevel(mySkillPointSum)
            case Buttons.button5:
                return Skill.button5SkillLevel(mySkillPointSum)
            case Buttons.button6, Buttons.button8:
                return Skill.button6And8SkillLevel(mySkillPointSum)
            default:
                return nil
            }
        }()
        self.nextLevelLabel.text = Skill.nextSkillLevel(of: self.skillLevelLabel.text ?? "", button: button)
        self.percentLabel.text = String(format: "%05.2f%%", mySkillPointSum * 100 / max)
    }
    
    @objc func touchUpTop50Button(_ sender: UIButton) {
        delegate?.touchUpTop50Button(sender)
    }
    
    @objc func touchUpRankingButton(_ sender: UIButton) {
        delegate?.touchUpRankingButton(sender)
    }
    
    @objc func touchUpCalculatorButton(_ sender: UIButton) {
        delegate?.touchUpCalculatorButton(sender)
    }
}
