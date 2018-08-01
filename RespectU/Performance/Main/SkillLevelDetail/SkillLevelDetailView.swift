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

    @IBOutlet weak var button: UILabel!
    @IBOutlet var gauge: Gauge!
    @IBOutlet weak var skillLevel: UILabel!
    @IBOutlet weak var skillPoint: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var performanceRecordRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.mainColor.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
    }
    
    func setProperties() {
        
    }
}
