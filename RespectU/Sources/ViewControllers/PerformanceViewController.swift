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

/// The performance view controller.
final class PerformanceViewController: UIViewController {
  
  /// The `enum` that defines cell identifiers.
  private enum CellIdentifier {
    
    /// The `SkillLevelCell` identifier.
    static let skillLevel = "skillLevelCell"
    
    /// The `SummaryCell` cell identifier.
    static let summary = "summaryCell"
    
    /// The `SummaryCollectionCell` cell identifier.
    static let summaryCollection = "summaryCollectionCell"
  }
  
  /// The api service.
  private let apiService: APIServiceType = APIService()
  
  /// The table view.
  @IBOutlet private weak var tableView: UITableView!
  
  /// The record button.
  @IBOutlet private weak var recordButton: UIButton!
  
  /// The nickname button.
  @IBOutlet private weak var nicknameButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    resetSubviews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presentRateView()
  }
  
  /// Configures initial settings.
  private func setup() {
    recordButton.layer.cornerRadius = recordButton.bounds.height / 2
    recordButton.layer.borderWidth = 1
    recordButton.layer.borderColor = UIColor.main.cgColor
    tableView.register(UINib(nibName: SkillLevelCell.name, bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.skillLevel)
    tableView.register(UINib(nibName: SummaryCell.name, bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.summary)
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    apiService.requestVersions(completion: versionRequestHandler)
  }
  
  /// Resets subviews.
  private func resetSubviews() {
    recordButton.setTitle(L10n.performanceRecord, for: .normal)
    nicknameButton.setTitle(Persistence.nickname, for: [])
    tableView.reloadData()
  }
  
  /// Tells the `sender` that the nickname button is tapped.
  @IBAction private func nicknameButtonDidTap(_ sender: UIButton) {
    let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
    if id.isEmpty {
      UIAlertController
        .alert(title: "", message: L10n.logInFirst)
        .action(title: L10n.ok)
        .present(to: self)
      return
    }
    let alert = UIAlertController
      .alert(title: L10n.nicknameSetting, message: L10n.enterYourNickname)
    alert
      .textField { $0.placeholder = L10n.nickname }
      .action(title: L10n.ok) { [weak self] _ in
        guard let self = self else { return }
        if let input = alert.textFields?.first?.text {
          if !input.isEmpty {
            self.apiService.uploadNickname(id: id,
                                           nickname: input,
                                           completion: self.nicknameUploadRequestHandler)
            let nickname = input.trimmingCharacters(in: .whitespaces)
            Persistence.nickname = nickname
            self.nicknameButton.setTitle(nickname, for: .normal)
          }
        }
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  /// Tells the `sender` that the next button is tapped.
  @IBAction private func nextButtonDidTap(_ sender: UIButton) {
    let controller = StoryboardScene.Guide.guideViewController.instantiate()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  /// Tells the `sender` that the record button is tapped.
  @IBAction private func recordButtonDidTap(_ sender: UIButton) {
    let controller = StoryboardScene.Record.recordViewController.instantiate()
    present(controller, animated: true)
  }
}

// MARK: - Request Handler

private extension PerformanceViewController {
  
  /// Handler for version request.
  ///
  /// - Parameters:
  ///   - response: The version response.
  ///   - error:    The passed error.
  func versionRequestHandler(response: VersionResponse?, error: Error?) {
    if let error = error {
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    guard let versionInfo = VersionInfo.fetch().first else { return }
    if version != response.clientVersion {
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: L10n.newVersionReleasedPleaseUseItAfterUpdating)
          .action(title: L10n.update) { _ in
            guard let url
              = URL(string: "itms-apps://itunes.apple.com/app/id1291664067") else { return }
            UIApplication.shared.open(url, options: [:])
          }
          .action(title: L10n.cancel, style: .cancel)
          .present(to: self)
      }
    } else if response.serverVersion != versionInfo.serverVersion {
      DispatchQueue.main.async {
        let message = L10n.ThereIsNewData.goToDownloadingFromTheServerAndUpdateToTheLatestData
        UIAlertController
          .alert(title: "", message: message)
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
  
  /// Handler for upload nickname request.
  ///
  /// - Parameters:
  ///   - statusCode: The status code.
  ///   - error:      The passed error.
  func nicknameUploadRequestHandler(statusCode: Int?, error: Error?) {
    if let error = error {
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let statusCode = statusCode else { return }
    if (200...299).contains(statusCode) {
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: L10n.successfullyChangingYourNickname)
          .action(title: L10n.ok)
          .present(to: self)
      }
    } else {
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: L10n.failedToChangingYourNickname)
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
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.skillLevel,
                                               for: indexPath)
      if case let skillLevelCell as SkillLevelCell = cell {
        let favoriteButton = Persistence.favoriteButton
        skillLevelCell.delegate = self
        skillLevelCell.selectionStyle = .none
        skillLevelCell.configure(inButton: favoriteButton,
                                 max: Utils.maxSkillPoint(in: favoriteButton),
                                 record: Utils.totalSkillPointAndHighestSeries(in: favoriteButton))
      }
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.summary,
                                               for: indexPath)
      if case let summaryCell as SummaryCell = cell {
        summaryCell.delegate = self
        summaryCell.selectionStyle = .none
        summaryCell.collectionView.dataSource = self
        summaryCell.collectionView
          .register(UINib(nibName: SummaryCollectionCell.name, bundle: nil),
                    forCellWithReuseIdentifier: CellIdentifier.summaryCollection)
      }
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
    return UITableView.automaticDimension
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
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: CellIdentifier.summaryCollection, for: indexPath)
    if case let summaryCollectionCell as SummaryCollectionCell = cell {
      summaryCollectionCell.configure(with: RecordInfo.fetch(), at: indexPath.item)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
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
  
  func summaryCell(_ cell: SummaryCell, didTapSearchButton button: UIButton) {
    let controller = StoryboardScene.Performance.searchRecordViewController.instantiate()
    present(controller, animated: true)
  }
  
  func summaryCell(_ cell: SummaryCell, didTapDetailButton button: UIButton) {
    let controller = StoryboardScene.Performance.summaryDetailViewController.instantiate()
    present(controller, animated: true)
  }
}

// MARK: - Private Method

private extension PerformanceViewController {
  
  func presentRateView() {
    Persistence.numberOfLaunching += 1
    if Persistence.numberOfLaunching % 10 == 0 {
      SKStoreReviewController.requestReview()
    }
  }
}
