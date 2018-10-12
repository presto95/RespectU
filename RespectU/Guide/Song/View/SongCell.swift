//
//  SongCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SongCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var composerLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var normalLabel: UILabel!
    @IBOutlet weak var hardLabel: UILabel!
    @IBOutlet weak var maximumLabel: UILabel!
    lazy var labels: [UILabel] = {
        return [titleLabel, composerLabel, bpmLabel, normalLabel, hardLabel, maximumLabel]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
        colorLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: SongInfo?, favoriteButton: String) {
        guard let object = object else { return }
        self.colorLabel.backgroundColor = object.series.seriesColor
        self.titleLabel.text = object.localizedTitle
        self.composerLabel.text = object.composer
        self.bpmLabel.text = object.bpmToString
        var buttons: SongButtonInfo?
        switch favoriteButton {
        case Buttons.button4:
            buttons = object.button4
        case Buttons.button5:
            buttons = object.button5
        case Buttons.button6:
            buttons = object.button6
        case Buttons.button8:
            buttons = object.button8
        default:
            break
        }
        guard let button = buttons else { return }
        self.normalLabel.text = button.normal == 0 ? "-" : "\(button.normal)"
        self.hardLabel.text = button.hard == 0 ? "-" : "\(button.hard)"
        self.maximumLabel.text = button.maximum == 0 ? "-" : "\(button.maximum)"
    }
}
