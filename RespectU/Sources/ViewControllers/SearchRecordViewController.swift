//
//  SearchByConditionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The search record view controller.
final class SearchRecordViewController: UIViewController {
  
  private let levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  
  private var selectedButtonIndex: Int = -1
  
  private var selectedLevelIndex: Int = -1
  
  private var selectedNoteDetailIndex: Int = -1
  
  private var selectedMethodIndex: Int = -1
  
  @IBOutlet private weak var button4Button: UIButton!
  
  @IBOutlet private weak var button5Button: UIButton!
  
  @IBOutlet private weak var button6Button: UIButton!
  
  @IBOutlet private weak var button8Button: UIButton!
  
  @IBOutlet private weak var searchByLevelButton: UIButton!
  
  @IBOutlet private weak var searchByRateButton: UIButton!
  
  @IBOutlet private weak var searchByNoteButton: UIButton!
  
  @IBOutlet private weak var subView: UIView!
  
  @IBOutlet private weak var searchButton: UIButton!
  
  private var buttonButtons = [UIButton?]()
  
  private var methodButtons = [UIButton?]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  private func configure() {
    searchByLevelButton.setTitle(L10n.level, for: [])
    searchByRateButton.setTitle(L10n.rating, for: [])
    searchByNoteButton.setTitle(L10n.note, for: [])
    searchButton.setTitle(L10n.enterAllConditions, for: .disabled)
    searchButton.setTitle(L10n.search, for: .normal)
    searchButton.layer.cornerRadius = searchButton.bounds.height / 2
    searchButton.layer.borderColor = UIColor.main.cgColor
    searchButton.layer.borderWidth = 1
    buttonButtons = [button4Button, button5Button, button6Button, button8Button]
    methodButtons = [searchByLevelButton, searchByRateButton, searchByNoteButton]
    initializeButtons()
    initializeMethods()
  }
  
  @IBAction private func searchButtonDidTap(_ sender: UIButton) {
    let controller = StoryboardScene.Performance.searchRecordDetailViewController.instantiate()
    controller.buttonIndex = { () -> Int in
      for index in 0..<4 {
        guard let button = buttonButtons[index] else { return -1 }
        if button.isSelected {
          return index
        }
      }
      return -1
    }()
    controller.methodIndex = { () -> Int in
      for index in 0..<3 {
        guard let button = methodButtons[index] else { return -1 }
        if button.isSelected {
          return index
        }
      }
      return -1
    }()
    if searchByLevelButton.isSelected {
      controller.levelIndex = selectedLevelIndex
    } else if searchByRateButton.isSelected {
      guard let rateView = subView.subviews.first as? SearchByRatingView else { return }
      let lowerRate = Double(rateView.lowerRatingTextField.text ?? "") ?? 0
      let upperRate = Double(rateView.upperRatingTextField.text ?? "") ?? 0
      controller.lowerRange = lowerRate
      controller.upperRange = upperRate
    } else if searchByNoteButton.isSelected {
      guard let noteView = subView.subviews.first as? SearchByNoteView else { return }
      controller.noteDetailIndex = { () -> Int in
        if noteView.noMaxComboButton.isSelected {
          return 0
        } else {
          return 1
        }
      }()
    }
    self.present(controller, animated: true)
  }
  
  @IBAction private func buttonsDidTap(_ sender: UIButton) {
    initializeButtons()
    for button in buttonButtons {
      button?.isSelected = false
    }
    sender.isSelected = true
    UIView.animate(withDuration: 0.3) {
      sender.backgroundColor = .main
    }
    switch sender.tag {
    case 0:
      selectedButtonIndex = 0
    case 1:
      selectedButtonIndex = 1
    case 2:
      selectedButtonIndex = 2
    case 3:
      selectedButtonIndex = 3
    default:
      break
    }
    checkValidity()
  }
  
  @IBAction private func methodButtonDidTap(_ sender: UIButton) {
    let view = subView.subviews.first
    if view is SearchByNoteView {
      selectedNoteDetailIndex = -1
    }
    if subView.subviews.count != 0 {
      subView.subviews.first?.removeFromSuperview()
    }
    initializeMethods()
    for type in methodButtons {
      type?.isSelected = false
    }
    sender.isSelected = true
    UIView.animate(withDuration: 0.3) {
      sender.backgroundColor = .main
    }
    switch sender.tag {
    case 0:
      selectedMethodIndex = 0
      guard let newView = UIView
        .instantiateFromXIB(xibName: SearchByLevelView.name) as? SearchByLevelView
        else { return }
      newView.pickerView.delegate = self
      newView.pickerView.dataSource = self
      subView.addSubview(newView)
      newView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        newView.topAnchor.constraint(equalTo: subView.topAnchor),
        newView.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 16),
        newView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -16),
        newView.heightAnchor.constraint(equalToConstant: 200)
        ])
    case 1:
      selectedMethodIndex = 1
      guard let newView = UIView
        .instantiateFromXIB(xibName: SearchByRatingView.name) as? SearchByRatingView
        else { return }
      newView.delegate = self
      newView.lowerRatingTextField
        .addTarget(self, action: #selector(ratingTextFieldEditingDidEnd), for: .editingDidEnd)
      newView.upperRatingTextField
        .addTarget(self, action: #selector(ratingTextFieldEditingDidEnd), for: .editingDidEnd)
      subView.addSubview(newView)
      newView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        newView.topAnchor.constraint(equalTo: subView.topAnchor),
        newView.leftAnchor.constraint(equalTo: subView.leftAnchor),
        newView.rightAnchor.constraint(equalTo: subView.rightAnchor),
        newView.heightAnchor.constraint(equalToConstant: 100)
        ])
    case 2:
      selectedMethodIndex = 2
      guard let newView = UIView
        .instantiateFromXIB(xibName: SearchByNoteView.name) as? SearchByNoteView
        else { return }
      newView.delegate = self
      newView.noMaxComboButton
        .addTarget(self, action: #selector(searchByNoteButtonDidTap), for: .touchUpInside)
      newView.perfectPlayButton
        .addTarget(self, action: #selector(searchByNoteButtonDidTap), for: .touchUpInside)
      subView.addSubview(newView)
      newView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        newView.topAnchor.constraint(equalTo: subView.topAnchor),
        newView.leftAnchor.constraint(equalTo: subView.leftAnchor),
        newView.rightAnchor.constraint(equalTo: subView.rightAnchor),
        newView.heightAnchor.constraint(equalToConstant: 100)
        ])
    default:
      break
    }
    checkValidity()
  }
  
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func searchByNoteButtonDidTap(_ sender: UIButton) {
    checkValidity()
  }
  
  @objc private func ratingTextFieldEditingDidEnd(_ sender: UITextField) {
    checkValidity()
  }
}

// MARK: - Conforming UIPickerViewDataSource

extension SearchRecordViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 15
  }
}

// MARK: - Conforming UIPickerViewDelegate

extension SearchRecordViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String? {
    return "\(levels[row])"
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedLevelIndex = row
    checkValidity()
  }
}

// MARK: - Conforming SearchByRateViewDelegate

extension SearchRecordViewController: SearchByRatingViewDelegate {
  
  func didTouchUpDoneButton(_ textFields: [UITextField]) {
    guard let lowerRateTextField = textFields.first else { return }
    guard let upperRateTextField = textFields.last else { return }
    if lowerRateTextField.isFirstResponder {
      lowerRateTextField.resignFirstResponder()
      setTextFieldText(lowerRateTextField)
    } else if upperRateTextField.isFirstResponder {
      upperRateTextField.resignFirstResponder()
      setTextFieldText(upperRateTextField)
    }
  }
  
  private func setTextFieldText(_ textField: UITextField) {
    guard let text = textField.text else { return }
    guard let value = Double(text) else { return }
    if value >= 100 {
      textField.text = "100"
    }
  }
}

// MARK: - Conforming SearchByNoteViewDelegate

extension SearchRecordViewController: SearchByNoteViewDelegate {
  
  func searchByNoteView(_ view: SearchByNoteView, didTapNoteButton button: UIButton) {
    switch button.tag {
    case 0:
      selectedNoteDetailIndex = 0
    case 1:
      selectedNoteDetailIndex = 1
    default:
      break
    }
  }
}

// MARK: - Private Method

private extension SearchRecordViewController {
  
  func initializeButtons() {
    for button in buttonButtons {
      UIView.animate(withDuration: 0.3) {
        button?.backgroundColor = .white
      }
    }
  }
  
  func initializeMethods() {
    for button in methodButtons {
      UIView.animate(withDuration: 0.3) {
        button?.backgroundColor = .white
      }
    }
  }
  
  func checkValidity() {
    searchButton.isEnabled = false
    let view = subView.subviews.first
    switch view {
    case is SearchByLevelView:
      if selectedLevelIndex != -1, selectedMethodIndex != -1, selectedButtonIndex != -1 {
        searchButton.isEnabled = true
      }
    case is SearchByRatingView:
      guard let newView = view as? SearchByRatingView else { return }
      guard let lowerText = newView.lowerRatingTextField.text else { return }
      guard let upperText = newView.upperRatingTextField.text else { return }
      guard let lower = Double(lowerText) else { return }
      guard let upper = Double(upperText) else { return }
      if upper > lower {
        searchButton.isEnabled = true
      }
    case is SearchByNoteView:
      if selectedNoteDetailIndex != -1, selectedMethodIndex != -1, selectedButtonIndex != -1 {
        searchButton.isEnabled = true
      }
    default:
      break
    }
  }
}
