//
//  RecordCell.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colorLabel.layer.borderWidth = 1
        self.colorLabel.layer.borderColor = UIColor.main.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: RecordInfo) {
        self.titleLabel.text = object.title
        self.colorLabel.backgroundColor = object.series.seriesColor
    }
    
    func setColorWhenSelected(_ series: String, isJust: Bool) {
        func setColor() {
            switch series {
            case Series.portable1:
                self.contentView.backgroundColor = UIColor.portable1
                self.titleLabel.textColor = .white
            case Series.portable2:
                self.contentView.backgroundColor = UIColor.portable2
                self.titleLabel.textColor = .white
            case Series.respect:
                self.contentView.backgroundColor = UIColor.respect
                self.titleLabel.textColor = .white
            case Series.trilogy:
                self.contentView.backgroundColor = UIColor.trilogy
                self.titleLabel.textColor = .white
            case Series.ce:
                self.contentView.backgroundColor = UIColor.ce
                self.titleLabel.textColor = .black
            case Series.technika1:
                self.contentView.backgroundColor = UIColor.technika1
                self.titleLabel.textColor = .white
            case Series.bs:
                self.contentView.backgroundColor = UIColor.bs
                self.titleLabel.textColor = .white
            default:
                break
            }
        }
        if isJust {
            UIView.animate(withDuration: 0.5) {
                setColor()
            }
        } else {
            setColor()
        }
    }
    
    func setColorWhenDeselected(isJust: Bool) {
        func setColor() {
            self.contentView.backgroundColor = UIColor.sub
            self.titleLabel.textColor = .black
        }
        if isJust {
            UIView.animate(withDuration: 0.5) { 
                setColor()
            }
        } else {
            setColor()
        }
    }
}
