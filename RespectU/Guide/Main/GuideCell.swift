//
//  GuideCollectionViewCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class GuideCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.main.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
    }
    
    func setProperties(_ image: UIImage, _ description: String) {
        self.iconImageView.image = image
        self.descriptionLabel.text = description
    }
    
    func becomeHighlighted() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: { [unowned self] in
                self.contentView.backgroundColor = .main
            })
        }
    }
    
    func becomeUnhighlighted() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: { [unowned self] in
                self.contentView.backgroundColor = .sub
            })
        }
    }
}
