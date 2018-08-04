//
//  SummaryCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

protocol SummaryCellDelegate: class {
    func touchUpDetailButton(_ sender: UIButton)
    func touchUpSearchButton(_ sender: UIButton)
}

class SummaryCell: UITableViewCell {

    var delegate: SummaryCellDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailButton.setTitle("Detail".localized, for: .normal)
        self.detailButton.layer.borderWidth = 2
        self.detailButton.layer.borderColor = UIColor.main.cgColor
        self.searchButton.setTitle("Search by Condition".localized, for: .normal)
        self.searchButton.layer.borderWidth = 2
        self.searchButton.layer.borderColor = UIColor.main.cgColor
        self.detailButton.addTarget(self, action: #selector(touchUpDetailButton(_:)), for: .touchUpInside)
        self.searchButton.addTarget(self, action: #selector(touchUpSearchButton(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func touchUpSearchButton(_ sender: UIButton) {
        delegate?.touchUpSearchButton(sender)
    }
    
    @objc func touchUpDetailButton(_ sender: UIButton) {
        delegate?.touchUpDetailButton(sender)
    }
}
