//
//  SongCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var composerLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var normalLabel: UILabel!
    @IBOutlet weak var hardLabel: UILabel!
    @IBOutlet weak var maximumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colorLabel.layer.borderColor = UIColor.mainColor.cgColor
        self.colorLabel.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: SongInfo, favoriteButton: String) {
        self.colorLabel.backgroundColor = object.series.color
        self.titleLabel.text = object.title
        self.composerLabel.text = object.composer
        self.bpmLabel.text = "BPM \(object.bpm)"
        switch favoriteButton {
        case Buttons.button4:
            self.normalLabel.text = object.nm4 == 0 ? "-" : "\(object.nm4)"
            self.hardLabel.text = object.hd4 == 0 ? "-" : "\(object.hd4)"
            self.maximumLabel.text = object.mx4 == 0 ? "-" : "\(object.mx4)"
        case Buttons.button5:
            self.normalLabel.text = object.nm5 == 0 ? "-" : "\(object.nm5)"
            self.hardLabel.text = object.hd5 == 0 ? "-" : "\(object.hd5)"
            self.maximumLabel.text = object.mx5 == 0 ? "-" : "\(object.mx5)"
        case Buttons.button6:
            self.normalLabel.text = object.nm6 == 0 ? "-" : "\(object.nm6)"
            self.hardLabel.text = object.hd6 == 0 ? "-" : "\(object.hd6)"
            self.maximumLabel.text = object.mx6 == 0 ? "-" : "\(object.mx6)"
        case Buttons.button8:
            self.normalLabel.text = object.nm8 == 0 ? "-" : "\(object.nm8)"
            self.hardLabel.text = object.hd8 == 0 ? "-" : "\(object.hd8)"
            self.maximumLabel.text = object.mx8 == 0 ? "-" : "\(object.mx8)"
        default:
            break
        }
    }
}
