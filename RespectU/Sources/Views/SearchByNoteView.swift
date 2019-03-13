//
//  SearchByNoteView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The `protocol` that defines delegate methods of the `SearchByNoteView`.
protocol SearchByNoteViewDelegate: class {
  
  /// Tells the delegate that the note button is tapped.
  func searchByNoteView(_ view: SearchByNoteView, didTapNoteButton button: UIButton)
}

/// The search by note view.
final class SearchByNoteView: UIView {
  
  /// The object that acts as the delegate of the `SearchByNoteView`.
  weak var delegate: SearchByNoteViewDelegate?
  
  /// The no max combo button.
  @IBOutlet private weak var noMaxComboButton: UIButton!
  
  /// The perfect play button.
  @IBOutlet private weak var perfectPlayButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    noMaxComboButton.setTitle(L10n.noMAXCOMBOs, for: .normal)
    perfectPlayButton.setTitle(L10n.perfectplaYs, for: .normal)
    initializeButtons()
  }
  
  /// Tells the `sender` that the buttons are tapped.
  @IBAction private func buttonsDidTap(_ sender: UIButton) {
    delegate?.searchByNoteView(self, didTapNoteButton: sender)
    initializeButtons()
    noMaxComboButton.isSelected = false
    perfectPlayButton.isSelected = false
    sender.isSelected = true
    UIView.animate(withDuration: 0.3) {
      sender.backgroundColor = .main
    }
  }
  
  /// Initializes buttons.
  private func initializeButtons() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.noMaxComboButton.backgroundColor = .white
      self?.perfectPlayButton.backgroundColor = .white
    }
  }
}
