//
//  SearchByNoteView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

protocol SearchByNoteViewDelegate: class {
  
  func searchByNoteView(_ view: SearchByNoteView, didTapNoteButton button: UIButton)
  
  //func didTouchUpNoteButtons(_ sender: UIButton)
}

final class SearchByNoteView: UIView {
  
  weak var delegate: SearchByNoteViewDelegate?
  
  @IBOutlet weak var noMaxComboButton: UIButton!
  
  @IBOutlet weak var perfectPlayButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    noMaxComboButton.setTitle(L10n.noMAXCOMBOs, for: .normal)
    perfectPlayButton.setTitle(L10n.perfectplaYs, for: .normal)
    initializeButtons()
  }
  
  @IBAction private func buttonsDidTap(_ sender: UIButton) {
    delegate?.searchByNoteView(self, didTapNoteButton: sender)
    //delegate?.didTouchUpNoteButtons(sender)
    initializeButtons()
    noMaxComboButton.isSelected = false
    perfectPlayButton.isSelected = false
    sender.isSelected = true
    UIView.animate(withDuration: 0.3) {
      sender.backgroundColor = .main
    }
  }
  
  private func initializeButtons() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.noMaxComboButton.backgroundColor = .white
      self?.perfectPlayButton.backgroundColor = .white
    }
  }
}
