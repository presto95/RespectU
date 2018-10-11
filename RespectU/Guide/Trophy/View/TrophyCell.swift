//
//  TrophyCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class TrophyCell: UITableViewCell {
    
    @IBOutlet weak var trophyImageView: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.layer.borderColor = UIColor.main.cgColor
        colorLabel.layer.borderWidth = 1
        trophyImageView.layer.borderWidth = 1
        trophyImageView.layer.borderColor = UIColor.main.cgColor
    }

    func setProperties(_ object: TrophyInfo?) {
        guard let object = object else { return }
        if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(object.image).png").path {
            if FileManager.default.fileExists(atPath: filePath) {
                self.trophyImageView.image = UIImage(contentsOfFile: filePath)
            }
        }
        titleLabel.text = object.localizedTitle
        contentLabel.text = object.localizedContent
        switch object.rating {
        case TrophyGrade.platinum:
            self.colorLabel.backgroundColor = .platinum
        case TrophyGrade.gold:
            self.colorLabel.backgroundColor = .gold
        case TrophyGrade.silver:
            self.colorLabel.backgroundColor = .silver
        case TrophyGrade.bronze:
            self.colorLabel.backgroundColor = .bronze
        default:
            break
        }
    }
}
