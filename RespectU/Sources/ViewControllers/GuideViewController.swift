//
//  GuideViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import MessageUI
import SafariServices
import UIKit

import SwiftKeychainWrapper
import Then

/// The view controller about guide.
final class GuideViewController: UIViewController {
  
  // MARK: Constant
  
  /// The `enum` defines constants.
  private enum Constant {
    
    /// The image names.
    static let imageNames = [
      ["song", "mission", "trophy", "achievement", "tip", "manual"],
      ["log", "bpmDefault", "favorite"],
      ["download", "upload", "email", "radio", "credit", "rate"]
    ]
    
    /// The section header titles.
    static let sectionHeaderTitles = ["GUIDE FOR DJMAX RESPECT", "PERSONAL SETTING", "MORE"]
    
    /// The cell titles.
    static let cellTitles = [
      ["Music", "Mission", "Trophy", "Achievement", "TIP", "Manual"],
      ["Login / Logout", "BPM Default Setting", "My Favorite Button"],
      [
        "Download From Server",
        "Upload To Server",
        "Send Email to Developer",
        "DJMAX Radio Station",
        "Credit",
        "Rate This App"
      ]
    ]
  }
  
  /// The `enum` defines cell identifiers.
  private enum CellIdentifier {
    
    /// The first cell identifier of the guide table view.
    static let first = "guideFirstCell"
    
    /// The second cell identifier of the guide table view.
    static let second = "guideSecondCell"
    
    /// The third cell identifier of the guide table view.
    static let third = "guideThirdCell"
  }
  
  /// The table view.
  @IBOutlet weak var tableView: UITableView!
  
  /// The 'record' button.
  @IBOutlet private weak var recordButton: UIButton!
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    tableView.register(UINib(nibName: GuideFirstCell.name, bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.first)
    tableView.register(UINib(nibName: GuideSecondCell.name, bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.second)
    tableView.register(UINib(nibName: GuideThirdCell.name, bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.third)
    tableView.separatorStyle = .none
    recordButton.setTitle(L10n.performanceRecord, for: .normal)
    recordButton.layer.cornerRadius = recordButton.bounds.height / 2
    recordButton.layer.borderWidth = 1
    recordButton.layer.borderColor = UIColor.main.cgColor
  }
  
  /// Tells the `sender` that the back button is tapped.
  @IBAction private func backButtonDidTap(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  /// Tells the `sender` that the record button is tapped.
  @IBAction private func recordButtonDidTap(_ sender: UIButton) {
    let controller = StoryboardScene.Record.recordViewController.instantiate()
    present(controller, animated: true)
  }
}

// MARK: - Conforming GuideFirstCellDelegate

extension GuideViewController: GuideFirstCellDelegate {
  
  func guideFirstCell(_ cell: GuideFirstCell, didTapSongStackView stackView: UIStackView) {
    let controller = StoryboardScene.Song.songViewController.instantiate()
    present(controller, animated: true)
  }
  
  func guideFirstCell(_ cell: GuideFirstCell, didTapMissionStackView stackView: UIStackView) {
    let controller = StoryboardScene.Mission.missionViewController.instantiate()
    present(controller, animated: true)
  }
  
  func guideFirstCell(_ cell: GuideFirstCell, didTapTrophyStackView stackView: UIStackView) {
    let controller = StoryboardScene.Trophy.trophyViewController.instantiate()
    present(controller, animated: true)
  }
  
  func guideFirstCell(_ cell: GuideFirstCell, didTapAchievementStackView stackView: UIStackView) {
    let controller = StoryboardScene.Achievement.achievementViewController.instantiate()
    present(controller, animated: true)
  }
  
  func guideFirstCell(_ cell: GuideFirstCell, didTapTipStackView stackView: UIStackView) {
    let controller = StoryboardScene.Tip.tipViewController.instantiate()
    present(controller, animated: true)
  }
  
  func guideFirstCell(_ cell: GuideFirstCell, didTapManualStackView stackView: UIStackView) {
    if !Reachability.isConnectedToNetwork() {
      presentNetworkAlert()
    } else {
      guard let url = URL(string: "http://djmaxrespect.com/manual.html") else { return }
      let config = SFSafariViewController.Configuration().then {
        $0.barCollapsingEnabled = true
      }
      let controller = SFSafariViewController(url: url, configuration: config).then {
        $0.preferredControlTintColor = .main
        $0.dismissButtonStyle = .close
      }
      present(controller, animated: true, completion: nil)
    }
  }
}

// MARK: - Conforming GuideSecondCellDelegate

extension GuideViewController: GuideSecondCellDelegate {
  
  func guideSecondCell(_ cell: GuideSecondCell, didTapLogInOutStackView stackView: UIStackView) {
    let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
    if !id.isEmpty {
      KeychainWrapper.standard.set("", forKey: "id")
      UIAlertController
        .alert(title: "", message: L10n.logOutCompleted)
        .action(title: L10n.ok)
        .present(to: self)
    } else {
      let controller = StoryboardScene.SignIn.signNavigationController.instantiate().then {
        $0.modalTransitionStyle = .crossDissolve
      }
      present(controller, animated: true, completion: nil)
    }
  }
  
  func guideSecondCell(_ cell: GuideSecondCell, didTapBPMSettingStackView stackView: UIStackView) {
    let message = L10n.current
      .appending(" : BPM \(Int(UserDefaults.standard.double(forKey: "bpm")))\n\n")
      .appending(L10n.itBecomesStandardOfSpeedRecommendation)
    let alert = UIAlertController
      .alert(title: L10n.bpmDefaultSetting, message: message)
      .textField {
        $0.placeholder = "BPM"
        $0.keyboardType = .numberPad
    }
    alert.action(title: L10n.ok) { _ in
      if let input = alert.textFields?.first?.text {
        if !input.isEmpty {
          guard let value = Double(input) else { return }
          UserDefaults.standard.do {
            $0.set(value, forKey: "bpm")
            $0.synchronize()
          }
        }
      }
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  func guideSecondCell(_ cell: GuideSecondCell,
                       didTapFavoriteButtonStackView stackView: UIStackView) {
    let key = "favoriteButton"
    let favorite = UserDefaults.standard.string(forKey: key)
    let message = L10n.current
      .appending(" : \(favorite?.uppercased() ?? L10n.none)\n\n")
      .appending(L10n.theInformationRelatedToTheSetValueIsDisplayedFirst)
    UIAlertController
      .alert(title: L10n.myFavoriteButton, message: message)
      .action(title: Button.button4.rawValue.uppercased()) { _ in
        UserDefaults.standard.do {
          $0.set(Button.button4.rawValue, forKey: key)
          $0.synchronize()
        }
      }
      .action(title: Button.button5.rawValue.uppercased()) { _ in
        UserDefaults.standard.do {
          $0.set(Button.button5.rawValue, forKey: key)
          $0.synchronize()
        }
      }
      .action(title: Button.button6.rawValue.uppercased()) { _ in
        UserDefaults.standard.do {
          $0.set(Button.button6.rawValue, forKey: key)
          $0.synchronize()
        }
      }
      .action(title: Button.button8.rawValue.uppercased()) { _ in
        UserDefaults.standard.do {
          $0.set(Button.button8.rawValue, forKey: key)
          $0.synchronize()
        }
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
}

// MARK: - Conforming GuideThirdCellDelegate

extension GuideViewController: GuideThirdCellDelegate {
  
  func guideThirdCell(_ cell: GuideThirdCell, didTapDownloadStackView stackView: UIStackView) {
    let controller = StoryboardScene.Download.downloadViewController.instantiate()
    present(controller, animated: true, completion: nil)
  }
  
  func guideThirdCell(_ cell: GuideThirdCell, didTapUploadStackView stackView: UIStackView) {
    let controller = StoryboardScene.Upload.uploadViewController.instantiate()
    present(controller, animated: true, completion: nil)
  }
  
  func guideThirdCell(_ cell: GuideThirdCell, didTapEmailStackView stackView: UIStackView) {
    presentMailComposeViewController()
  }
  
  func guideThirdCell(_ cell: GuideThirdCell, didTapRadioStackView stackView: UIStackView) {
    if !Reachability.isConnectedToNetwork() {
      presentNetworkAlert()
    } else {
      guard let url = URL(string: "https://djmax.protomox.com") else { return }
      let config = SFSafariViewController.Configuration().then {
        $0.barCollapsingEnabled = true
      }
      let controller = SFSafariViewController(url: url, configuration: config).then {
        $0.preferredControlTintColor = .main
        $0.dismissButtonStyle = .close
      }
      present(controller, animated: true, completion: nil)
    }
  }
  
  func guideThirdCell(_ cell: GuideThirdCell, didTapCreditStackView stackView: UIStackView) {
    guard let versionInfo = VersionInfo.fetch().first else { return }
    let gameVersion = versionInfo.gameVersion
    let serverVersion = versionInfo.serverVersion
    let message = "PSN ID : Presto_95\n\n"
      .appending("DJMAX RESPECT \(gameVersion)\n")
      .appending("RespectU \(version)\n")
      .appending("RespectU (Server) \(serverVersion)\n\n")
      .appending("App icon by icons8")
    UIAlertController
      .alert(title: L10n.credits, message: message)
      .action(title: L10n.ok)
      .present(to: self)
  }
  
  func guideThirdCell(_ cell: GuideThirdCell, didTapRateStackView stackView: UIStackView) {
    openAppStore(appID: "id1291664067")
  }
}

// MARK: - Conforming UITableViewDataSource

extension GuideViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell
        = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.first, for: indexPath)
      if case let firstCell as GuideFirstCell = cell {
        firstCell.delegate = self
      }
      return cell
    case 1:
      let cell
        = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.second, for: indexPath)
      if case let secondCell as GuideSecondCell = cell {
        secondCell.delegate = self
      }
      return cell
    case 2:
      let cell
        = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.third, for: indexPath)
      if case let thirdCell as GuideThirdCell = cell {
        thirdCell.delegate = self
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
    return 3
  }
}

// MARK: - Conforming UITableViewDelegate

extension GuideViewController: UITableViewDelegate {
  
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

// MARK: - Conforming MFMailComposeViewControllerDelegate

extension GuideViewController: MFMailComposeViewControllerDelegate {
  
  func mailComposeController(_ controller: MFMailComposeViewController,
                             didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

// MARK: - Private Method

private extension GuideViewController {
  
  func presentNetworkAlert() {
    UIAlertController
      .alert(title: "", message: L10n.checkYourNetworkStatus)
      .action(title: L10n.ok)
      .present(to: self)
  }
  
  func presentMailComposeViewController() {
    if MFMailComposeViewController.canSendMail() {
      let mail = MFMailComposeViewController().then {
        $0.mailComposeDelegate = self
        $0.setToRecipients(["yoohan95@gmail.com"])
      }
      present(mail, animated: true)
    }
  }
  
  func openAppStore(appID: String, completion: ((_ success: Bool) -> Void)? = nil) {
    guard let url = URL(string: "itms-apps://itunes.apple.com/app/\(appID)") else {
      completion?(false)
      return
    }
    guard #available(iOS 10, *) else {
      completion?(UIApplication.shared.openURL(url))
      return
    }
    UIApplication.shared.open(url, options: [:], completionHandler: completion)
  }
}
