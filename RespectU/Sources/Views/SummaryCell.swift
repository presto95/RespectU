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
  func didTouchUpDetailButton(_ sender: UIButton)
  func didTouchUpSearchButton(_ sender: UIButton)
}

final class SummaryCell: UITableViewCell {
  
  weak var delegate: SummaryCellDelegate?
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var view: UIView!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var detailButton: UIButton!
  
  @IBOutlet weak var searchButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.text = "Summary".localized
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.masksToBounds = true
    self.detailButton.setTitle("Detail".localized, for: .normal)
    self.searchButton.setTitle("Search by Condition".localized, for: .normal)
    self.detailButton.addTarget(self, action: #selector(didTouchUpDetailButton(_:)), for: .touchUpInside)
    self.searchButton.addTarget(self, action: #selector(didTouchUpSearchButton(_:)), for: .touchUpInside)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @objc func didTouchUpSearchButton(_ sender: UIButton) {
    delegate?.didTouchUpSearchButton(sender)
  }
  
  @objc func didTouchUpDetailButton(_ sender: UIButton) {
    delegate?.didTouchUpDetailButton(sender)
  }
}
