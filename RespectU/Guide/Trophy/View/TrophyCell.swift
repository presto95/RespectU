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
        self.colorLabel.layer.borderColor = UIColor.main.cgColor
        self.colorLabel.layer.borderWidth = 1
        self.trophyImageView.layer.borderWidth = 1
        self.trophyImageView.layer.borderColor = UIColor.main.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: TrophyInfo?) {
        guard let object = object else { return }
        let imageUrl = "\(API.baseUrl)/images/\(object.series)/\(object.image).png"
        guard let url = URL(string: imageUrl) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.trophyImageView.image = UIImage(data: imageData, scale: 0.5)
            }
        }
        self.titleLabel.text = object.localizedTitle
        self.contentLabel.text = object.localizedContent
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
