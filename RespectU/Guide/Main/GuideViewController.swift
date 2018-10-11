//
//  GuideViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import MessageUI

class GuideViewController: UIViewController {

    private let imageNames = [["song", "mission", "trophy", "achievement", "tip", "manual"], ["log", "bpmDefault", "favorite"], ["download", "upload", "email", "radio", "credit", "rate"]]
    private let sectionHeaderTitles = ["GUIDE FOR DJMAX RESPECT", "PERSONAL SETTING", "MORE"]
    private let cellTitles = [["Music", "Mission", "Trophy", "Achievement", "TIP", "Manual"], ["Login / Logout", "BPM Default Setting", "My Favorite Button"], ["Download From Server", "Upload To Server", "Send Email to Developer", "DJMAX Radio Station", "Credit", "Rate This App"]]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GuideFirstCell", bundle: nil), forCellReuseIdentifier: "guideFirstCell")
        tableView.register(UINib(nibName: "GuideSecondCell", bundle: nil), forCellReuseIdentifier: "guideSecondCell")
        tableView.register(UINib(nibName: "GuideThirdCell", bundle: nil), forCellReuseIdentifier: "guideThirdCell")
        tableView.separatorStyle = .none
        recordButton.setTitle("Performance Record".localized, for: .normal)
        recordButton.layer.cornerRadius = recordButton.bounds.height / 2
        recordButton.layer.borderWidth = 1
        recordButton.layer.borderColor = UIColor.main.cgColor
    }
    
    @IBAction func didTouchUpPreviousButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTouchUpRecordButton(_ sender: UIButton) {
        guard let controller = UIViewController.instantiate(storyboard: "Record", identifier: RecordViewController.classNameToString) as? RecordViewController else { return }
        self.present(controller, animated: true)
    }
}

extension GuideViewController: GuideFirstCellDelegate {
    func didTapSongStackView() {
        guard let controller = UIViewController.instantiate(storyboard: "Song", identifier: SongViewController.classNameToString) as? SongViewController else { return }
        self.present(controller, animated: true)
    }
    
    func didTapMissionStackView() {
        guard let controller = UIViewController.instantiate(storyboard: "Mission", identifier: MissionViewController.classNameToString) as? MissionViewController else { return }
        self.present(controller, animated: true)
    }
    
    func didTapTrophyStackView() {
        guard let controller = UIViewController.instantiate(storyboard: "Trophy", identifier: TrophyViewController.classNameToString) as? TrophyViewController else { return }
        self.present(controller, animated: true)
    }
    
    func didTapAchievementStackView() {
        guard let controller = UIViewController.instantiate(storyboard: "Achievement", identifier: AchievementViewController.classNameToString) as? AchievementViewController else { return }
        self.present(controller, animated: true)
    }
    
    func didTapTipStackView() {
        guard let controller = UIViewController.instantiate(storyboard: "Tip", identifier: TipViewController.classNameToString) as? TipViewController else { return }
        self.present(controller, animated: true)
    }
    
    func didTapManualStackView() {
        if !Reachability.isConnectedToNetwork() {
            presentNetworkAlert()
        } else {
            guard let controller = UIViewController.instantiate(storyboard: "Manual", identifier: ManualViewController.classNameToString) as? ManualViewController else { return }
            self.present(controller, animated: true)
        }
    }
}

extension GuideViewController: GuideSecondCellDelegate {
    func didTapUpLogInOutStackView() {
        let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
        if !id.isEmpty {
            KeychainWrapper.standard.set("", forKey: "id")
            UIAlertController
                .alert(title: "", message: "Log Out Completed".localized)
                .action(title: "OK".localized)
                .present(to: self)
        } else {
            guard let next = UIViewController.instantiate(storyboard: "SignIn", identifier: "SignNavigationController") else { return }
            next.modalTransitionStyle = .crossDissolve
            self.present(next, animated: true, completion: nil)
        }
    }
    
    func didTapBPMSettingStackView() {
        let message = "Current".localized + " : BPM \(Int(UserDefaults.standard.double(forKey: "bpm")))\n\n" + "It becomes standard of Speed Recommendation.".localized
        let alert = UIAlertController
            .alert(title: "BPM Default Setting".localized, message: message)
            .textField { (textField) in
                textField.placeholder = "BPM"
                textField.keyboardType = .numberPad
        }
        alert.action(title: "OK".localized) { _ in
            if let input = alert.textFields?.first?.text {
                if !input.isEmpty {
                    guard let value = Double(input) else { return }
                    UserDefaults.standard.set(value, forKey: "bpm")
                    UserDefaults.standard.synchronize()
                }
            }
            }
            .action(.cancel, title: "Cancel".localized)
            .present(to: self)
    }
    
    func didTapFavoriteButtonStackView() {
        let key = "favoriteButton"
        let favorite = UserDefaults.standard.string(forKey: key)
        let message = "Current".localized + " : \(favorite?.uppercased() ?? "None".localized)\n\n" + "The information related to the set value is displayed first.".localized
        UIAlertController
            .alert(title: "My Favorite Button".localized, message: message)
            .action(title: Buttons.button4.uppercased()) { _ in
                UserDefaults.standard.set(Buttons.button4, forKey: key)
            }
            .action(title: Buttons.button5.uppercased()) { _ in
                UserDefaults.standard.set(Buttons.button5, forKey: key)
            }
            .action(title: Buttons.button6.uppercased()) { _ in
                UserDefaults.standard.set(Buttons.button6, forKey: key)
            }
            .action(title: Buttons.button8.uppercased()) { _ in
                UserDefaults.standard.set(Buttons.button8, forKey: key)
            }
            .action(.cancel, title: "Cancel".localized)
            .present(to: self)
    }
}

extension GuideViewController: GuideThirdCellDelegate {
    func didTapDownloadStackView() {
        guard let next = UIViewController.instantiate(storyboard: "Download", identifier: DownloadViewController.classNameToString) else { return }
        self.present(next, animated: true, completion: nil)
    }
    
    func didTapUploadStackView() {
        guard let next = UIViewController.instantiate(storyboard: "Upload", identifier: UploadViewController.classNameToString) else { return }
        self.present(next, animated: true, completion: nil)
    }
    
    func didTapEmailStackView() {
        sendEmail()
    }
    
    func didTapRadioStackView() {
        if !Reachability.isConnectedToNetwork() {
            presentNetworkAlert()
        } else {
            guard let controller = UIViewController.instantiate(storyboard: "Radio", identifier: RadioViewController.classNameToString) as? RadioViewController else { return }
            self.present(controller, animated: true)
        }
    }
    
    func didTapCreditStackView() {
        guard let versionInfo = VersionInfo.fetch().first else { return }
        let gameVersion = versionInfo.gameVersion
        let serverVersion = versionInfo.serverVersion
        let message = "PSN ID : Presto_95\n\nDJMAX RESPECT \(gameVersion)\nRespectU (iOS) \(version)\nRespectU (Server) \(serverVersion)\n\nApp icon by icons8"
        UIAlertController
            .alert(title: "CREDITS".localized, message: message)
            .action(title: "OK".localized)
            .present(to: self)
    }
    
    func didTapRateStackView() {
        self.rateApp(appId: "id1291664067")
    }
}

extension GuideViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "guideFirstCell", for: indexPath) as? GuideFirstCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "guideSecondCell", for: indexPath) as? GuideSecondCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "guideThirdCell", for: indexPath) as? GuideThirdCell else { return UITableViewCell() }
            cell.delegate = self
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

extension GuideViewController {
    private func presentNetworkAlert() {
        UIAlertController
            .alert(title: "", message: "Check your network status.".localized)
            .action(title: "OK".localized)
            .present(to: self)
    }
}

extension GuideViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

private extension GuideViewController {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["yoohan95@gmail.com"])
            self.present(mail, animated: true)
        }
    }
    
    func rateApp(appId: String, completion: ((_ success: Bool) -> Void)? = nil) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + appId) else {
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
