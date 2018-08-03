//
//  SkillDetailView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import GaugeKit

class SkillLevelDetailView: UIView {

    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet var gauge: Gauge!
    @IBOutlet weak var skillLevelLabel: UILabel!
    @IBOutlet weak var skillPointLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var recordRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.mainColor.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
    }
    
    func setProperties() {
        
    }
}
