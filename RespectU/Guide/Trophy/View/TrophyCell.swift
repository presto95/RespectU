//
//  TrophyCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class TrophyCell: UITableViewCell {
    
    @IBOutlet weak var trophyThumbnailImageView: UIImageView!
    @IBOutlet weak var trophyGradeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trophyThumbnailImageView.layer.cornerRadius = trophyThumbnailImageView.bounds.height / 2
        trophyThumbnailImageView.layer.masksToBounds = true
    }

    func setProperties(_ object: TrophyInfo?) {
        guard let object = object else { return }
        if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(object.image).png").path {
            if FileManager.default.fileExists(atPath: filePath) {
                trophyThumbnailImageView.image = UIImage(contentsOfFile: filePath)
            }
        }
        titleLabel.text = object.localizedTitle
        contentLabel.text = object.localizedContent
        switch object.rating {
        case TrophyGrade.platinum:
            trophyGradeImageView.image = UIImage(named: "platinum")
        case TrophyGrade.gold:
            trophyGradeImageView.image = UIImage(named: "gold")
        case TrophyGrade.silver:
            trophyGradeImageView.image = UIImage(named: "silver")
        case TrophyGrade.bronze:
            trophyGradeImageView.image = UIImage(named: "bronze")
        default:
            break
        }
    }
}
