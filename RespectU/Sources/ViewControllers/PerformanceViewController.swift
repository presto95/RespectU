//
//  PerformanceViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift
import StoreKit
import SwiftKeychainWrapper

final class PerformanceViewController: UIViewController {
  
  private enum CellIdentifier {
    
    
  }
  
  private let apiService: APIServiceType = APIService()
  
  @IBOutlet private weak var tableView: UITableView!
  
  @IBOutlet private weak var recordButton: UIButton!
  
  @IBOutlet private weak var nicknameButton: UIButton!
  
  var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? Button.button4
  
  override func viewDidLoad() {
    super.viewDidLoad()
    recordButton.layer.cornerRadius = recordButton.bounds.height / 2
    recordButton.layer.borderWidth = 1
    recordButton.layer.borderColor = UIColor.main.cgColor
    tableView.register(UINib(nibName: "SkillLevelCell", bundle: nil), forCellReuseIdentifier: "skillLevelCell")
    tableView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "summaryCell")
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    APIService.requestVersions(completion: didReceiveVersions)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    setup()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presentRateView()
  }
  
  private func setup() {
    recordButton.setTitle(L10n.performanceRecord, for: .normal)
    favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? Button.button4
    nicknameButton.setTitle(UserDefaults.standard.string(forKey: "nickname") ?? L10n.nicknameSetting, for: [])
    tableView.reloadData()
  }
  
  @IBAction private func nicknameButtonDidTap(_ sender: UIButton) {
    let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
    if id.isEmpty {
      UIAlertController
        .alert(title: "", message: L10n.logInFirst)
        .action(title: L10n.ok)
        .present(to: self)
      return
    }
    let alert = UIAlertController.alert(title: L10n.nicknameSetting, message: L10n.enterYourNickname)
    alert.textField { textField in
      textField.placeholder = L10n.nickname
      }
      .action(title: L10n.ok) { [weak self] _ in
        if let input = alert.textFields?.first?.text {
          if !input.isEmpty {
            apiservice.uploadNickname(id: id, nickname: input, completion: self?.didReceiveUploadNickname)
            let nickname = input.trimmingCharacters(in: .whitespaces)
            UserDefaults.standard.do {
              $0.set(nickname, forKey: "nickname")
              $0.synchronize()
            }
            self?.nicknameButton.setTitle(nickname, for: .normal)
          }
        }
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  @IBAction private func nextButtonDidTap(_ sender: UIButton) {
    let controller = StoryboardScene.Guide.guideViewController.instantiate()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @IBAction private func recordButtonDidTap(_ sender: UIButton) {
    let controller = StoryboardScene.Record.recordViewController.instantiate()
    present(controller, animated: true)
  }
}

// MARK: - Version

private extension PerformanceViewController {
  
  func didReceiveVersions(response: VersionResponse?, error: Error?) {
    if let error = error {
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    guard let versionInfo = VersionInfo.fetch().first else { return }
    if version != response.clientVersion {
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: "New version released!\nPlease use it after updating.".localized)
          .action(title: L10n.update) { _ in
            guard let url = URL(string: "itms-apps://itunes.apple.com/app/id1291664067") else { return }
            guard #available(iOS 10, *) else {
              UIApplication.shared.openURL(url)
              return
            }
            UIApplication.shared.open(url, options: [:])
          }
          .action(title: "Cancel".localized, style: .cancel)
          .present(to: self)
      }
    } else if response.serverVersion != versionInfo.serverVersion {
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: "There is new data.\nGo to \"Downloading from the server\" and update to the latest data.".localized)
          .action(title: L10n.ok) { [weak self] _ in
            guard let self = self else { return }
            NotificationCenter.default.removeObserver(self)
            let controller = StoryboardScene.Download.downloadViewController.instantiate()
            self.present(controller, animated: true, completion: nil)
          }
          .action(title: L10n.cancel, style: .cancel)
          .present(to: self)
      }
    }
  }
}

// MARK: - Nickname

private extension PerformanceViewController {
  
  func didReceiveUploadNickname(statusCode: Int?, error: Error?) {
    if let error = error {
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let statusCode = statusCode else { return }
    if (200...299).contains(statusCode) {
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: "Succeeded to change nickname".localized)
          .action(title: L10n.ok)
          .present(to: self)
      }
    } else {
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: "Failed to change nickname".localized)
          .action(title: L10n.ok)
          .present(to: self)
      }
    }
  }
}

// MARK: - Conforming UITableViewDataSource

extension PerformanceViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "skillLevelCell", for: indexPath) as? SkillLevelCell else { return UITableViewCell() }
      cell.delegate = self
      cell.selectionStyle = .none
      cell.setProperties(favoriteButton, max: Skill.maxSkillPoint(button: favoriteButton), myRecord: Skill.mySkillPointAndHighestSeries(button: favoriteButton))
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? SummaryCell else { return UITableViewCell() }
      cell.delegate = self
      cell.selectionStyle = .none
      cell.collectionView.dataSource = self
      cell.collectionView.register(UINib(nibName: "SummaryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "summaryCollectionCell")
      return cell
    default:
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
}

// MARK: - Conforming UITableViewDelegate

extension PerformanceViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return .leastNormalMagnitude
  }
}

// MARK: - Conforming UICollectionViewDataSource

extension PerformanceViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "summaryCollectionCell", for: indexPath)
    if case let summaryCollectionCell as SummaryCollectionCell = cell {
      summaryCollectionCell.setProperties(RecordInfo.fetch(), at: indexPath.item)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
}

// MARK: - Conforming SkillLevelCellDelegate

extension PerformanceViewController: SkillLevelCellDelegate {
  
  func skillLevelCell(_ cell: SkillLevelCell, didTapTop50Button button: UIButton) {
    let controller = StoryboardScene.Top50.top50ViewController.instantiate()
    present(controller, animated: true)
  }
  
  func skillLevelCell(_ cell: SkillLevelCell, didTapMoreButton button: UIButton) {
    let controller = StoryboardScene.Performance.skillLevelDetailViewController.instantiate()
    present(controller, animated: true)
  }
}

// MARK: - Conforming SummaryCellDelegate

extension PerformanceViewController: SummaryCellDelegate {
  
  func didTouchUpDetailButton(_ sender: UIButton) {
    let controller = StoryboardScene.Performance.summaryDetailViewController.instantiate()
    present(controller, animated: true)
  }
  
  func didTouchUpSearchButton(_ sender: UIButton) {
    let controller = StoryboardScene.Performance.searchRecordViewController.instantiate()
    present(controller, animated: true)
  }
}

extension PerformanceViewController {
  
  private func presentRateView() {
    if #available(iOS 10.3, *) {
      let appOpenCount = UserDefaults.standard.integer(forKey: "appOpenCount")
      UserDefaults.standard.set(appOpenCount + 1, forKey: "appOpenCount")
      if UserDefaults.standard.integer(forKey: "appOpenCount") % 10 == 0 {
        SKStoreReviewController.requestReview()
      }
    }
  }
}
