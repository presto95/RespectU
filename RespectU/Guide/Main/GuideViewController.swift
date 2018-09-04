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
    private let sectionHeaderTitles = ["Guide for DJMAX RESPECT", "Personal Setting", "More"]
    private let cellTitles = [["Music", "Mission", "Trophy", "Achievement", "TIP", "Manual"], ["Login / Logout", "BPM Default Setting", "My Favorite Button"], ["Download From Server", "Upload To Server", "Send Email to Developer", "DJMAX Radio Station", "Credit", "Rate This App"]]
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordButton.setTitle("Performance Record".localized, for: .normal)
    }
    
    @IBAction func touchUpPreviousButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpRecordButton(_ sender: UIButton) {
        guard let vc = UIViewController.instantiate(storyboard: "Record", identifier: RecordViewController.classNameToString) as? RecordViewController else { return }
        self.present(vc, animated: true)
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["yoohan95@gmail.com"])
            self.present(mail, animated: true)
        }
    }
    
    private func rateApp(appId: String, completion: ((_ success: Bool) -> ())? = nil){
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

extension GuideViewController {
    private func presentNetworkAlert() {
        UIAlertController
            .alert(title: "", message: "Check your network status.".localized)
            .action(title: "OK".localized)
            .present(to: self)
    }
}

extension GuideViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension GuideViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guideCell", for: indexPath) as? GuideCell else { return UICollectionViewCell() }
        let icon = UIImage(imageLiteralResourceName: imageNames[indexPath.section][indexPath.row])
        let description = self.cellTitles[indexPath.section][indexPath.row].localized
        cell.setProperties(icon, description)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 6
        case 1:
            return 3
        case 2:
            return 6
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "guideSection", for: indexPath) as? GuideReusableView else { return UICollectionReusableView() }
        sectionHeader.setProperties(self.sectionHeaderTitles[indexPath.section].localized)
        return sectionHeader
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
}

extension GuideViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GuideCell else { return }
        cell.becomeHighlighted()
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GuideCell else { return }
        cell.becomeUnhighlighted()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                guard let vc = UIViewController.instantiate(storyboard: "Song", identifier: SongViewController.classNameToString) as? SongViewController else { return }
                self.present(vc, animated: true)
            case 1:
                guard let vc = UIViewController.instantiate(storyboard: "Mission", identifier: MissionViewController.classNameToString) as? MissionViewController else { return }
                self.present(vc, animated: true)
            case 2:
                guard let vc = UIViewController.instantiate(storyboard: "Trophy", identifier: TrophyViewController.classNameToString) as? TrophyViewController else { return }
                self.present(vc, animated: true)
            case 3:
                guard let vc = UIViewController.instantiate(storyboard: "Achievement", identifier: AchievementViewController.classNameToString) as? AchievementViewController else { return }
                self.present(vc, animated: true)
            case 4:
                guard let vc = UIViewController.instantiate(storyboard: "Tip", identifier: TipViewController.classNameToString) as? TipViewController else { return }
                self.present(vc, animated: true)
            case 5:
                if !Reachability.isConnectedToNetwork() {
                    presentNetworkAlert()
                } else {
                    guard let vc = UIViewController.instantiate(storyboard: "Manual", identifier: ManualViewController.classNameToString) as? ManualViewController else { return }
                    self.present(vc, animated: true)
                }
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
                if !id.isEmpty {
                    KeychainWrapper.standard.set("", forKey: "id")
                    UIAlertController
                        .alert(title: "", message: "Log Out Completed")
                        .action(title: "OK".localized)
                        .present(to: self)
                } else {
                    guard let next = UIViewController.instantiate(storyboard: "SignIn", identifier: "SignNavigationController") else { return }
                    next.modalTransitionStyle = .crossDissolve
                    self.present(next, animated: true, completion: nil)
                }
            case 1:
                
                let message = "Current".localized + " : BPM \(Int(UserDefaults.standard.double(forKey: "bpm")))\n\n" + "It becomes standard of Speed Recommendation.".localized
                let alert = UIAlertController
                    .alert(title: "BPM Default Setting".localized, message: message)
                    .textField { (textField) in
                        textField.placeholder = "BPM"
                        textField.keyboardType = .numberPad
                    }
                alert.action(title: "OK".localized) { (action) in
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
            case 2:
                let key = "favoriteButton"
                let favorite = UserDefaults.standard.string(forKey: key)
                let message = "Current".localized + " : \(favorite?.buttonExpansion ?? "None".localized)\n\n" + "The information related to the set value is displayed first.".localized
                UIAlertController
                    .alert(title: "My Favorite Button".localized, message: message)
                    .action(title: Buttons.button4.uppercased()) { (action) in
                        UserDefaults.standard.set(Buttons.button4, forKey: key)
                    }
                    .action(title: Buttons.button5.uppercased()) { (action) in
                        UserDefaults.standard.set(Buttons.button5, forKey: key)
                    }
                    .action(title: Buttons.button6.uppercased()) { (action) in
                        UserDefaults.standard.set(Buttons.button6, forKey: key)
                    }
                    .action(title: Buttons.button8.uppercased()) { (action) in
                        UserDefaults.standard.set(Buttons.button8, forKey: key)
                    }
                    .action(.cancel, title: "Cancel".localized)
                    .present(to: self)
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                guard let next = UIViewController.instantiate(storyboard: "Download", identifier: "DownloadViewController") else { return }
                self.present(next, animated: true, completion: nil)
            case 1:
                guard let next = UIViewController.instantiate(storyboard: "Upload", identifier: "UploadViewController") else { return }
                self.present(next, animated: true, completion: nil)
            case 2:
                sendEmail()
            case 3:
                if !Reachability.isConnectedToNetwork() {
                    presentNetworkAlert()
                } else {
                    guard let vc = UIViewController.instantiate(storyboard: "Radio", identifier: RadioViewController.classNameToString) as? RadioViewController else { return }
                    self.present(vc, animated: true)
                }
            case 4:
                guard let versionInfo = VersionInfo.fetch().first else { return }
                let clientversion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
                let gameVersion = versionInfo.gameVersion
                let serverVersion = versionInfo.serverVersion
                let message = "PSN ID : Presto_95\n\nDJMAX RESPECT \(gameVersion)\nRespectU (iOS) \(clientversion)\nRespectU (Server) \(serverVersion)\n\nApp icon by icons8"
                UIAlertController
                    .alert(title: "CREDITS".localized, message: message)
                    .action(title: "OK".localized)
                    .present(to: self)
            case 5:
                self.rateApp(appId: "id1291664067")
            default:
                break
            }
        default:
            break
        }
    }
}

extension GuideViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}


