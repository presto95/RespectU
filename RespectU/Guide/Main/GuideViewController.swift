//
//  GuideViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import MessageUI
import FirebaseAuth
import GoogleSignIn

class GuideViewController: UIViewController, GIDSignInUIDelegate {

    private let imageNames = [["song", "mission", "trophy", "achievement", "tip", "manual"], ["log", "bpmDefault", "favoriteButton"], ["radio", "email", "credit"]]
    private let sectionHeaderTitles = ["Guide for DJMAX RESPECT", "Personal Setting", "More"]
    private let cellTitles = [["Music", "Mission", "Trophy", "Achievement", "TIP", "Manual"], ["Login / Logout", "BPM Default Setting", "My Favorite Button"], ["DJMAX Radio Station", "Send Email to Developer", "Credit"]]
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        self.recordButton.setTitle("Performance Record".localized, for: .normal)
    }
    
    @IBAction func touchUpPreviousButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpRecordButton(_ sender: UIButton) {
        self.present(RecordViewController.instantiate()!, animated: true)
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["yoohan95@gmail.com"])
            self.present(mail, animated: true)
        }
    }
    
    private func rateApp(appId: String, completion: @escaping ((_ success: Bool) -> ())){
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [ : ], completionHandler: completion)
    }
}

extension GuideViewController {
    private func presentNetworkAlert() {
        UIAlertController
            .alert(title: "Notice".localized, message: "Check your network status.".localized)
            .defaultAction(title: "OK".localized)
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
            return 3
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
                self.present(SongViewController.instantiate()!, animated: true)
            case 1:
                self.present(MissionViewController.instantiate()!, animated: true)
            case 2:
                self.present(TrophyViewController.instantiate()!, animated: true)
            case 3:
                self.present(AchievementViewController.instantiate()!, animated: true)
            case 4:
                self.present(TipViewController.instantiate()!, animated: true)
            case 5:
                if !Reachability.isConnectedToNetwork() {
                    presentNetworkAlert()
                } else {
                    self.present(ManualViewController.instantiate()!, animated: true, completion: nil)
                }
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                if Auth.auth().currentUser == nil {
                    GIDSignIn.sharedInstance().signIn()
                    UIAlertController
                        .alert(title: "Notice".localized, message: "You have been logged in.".localized)
                        .defaultAction(title: "OK".localized)
                        .present(to: self)
                } else {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print(error.localizedDescription)
                    }
                    UIAlertController
                        .alert(title: "Notice".localized, message: "You have been logged out.".localized)
                        .defaultAction(title: "OK".localized)
                        .present(to: self)
                }
            case 1:
                let message = "Current".localized + " : BPM \(Int(UserDefaults.standard.double(forKey: "bpm")))\n\n" + "It becomes standard of Speed Recommendation.".localized
                let alert = UIAlertController
                    .alert(title: "BPM Default Setting".localized, message: message)
                    .textField { (textField) in
                        textField.placeholder = "BPM"
                        textField.keyboardType = .numberPad
                    }
                alert.defaultAction(title: "OK".localized) { (action) in
                    if let input = alert.textFields?.first?.text {
                        if !input.isEmpty {
                            guard let value = Double(input) else { return }
                            UserDefaults.standard.set(value, forKey: "bpm")
                            UserDefaults.standard.synchronize()
                        }
                    }
                }
                .cancelAction(title: "Cancel".localized)
                .present(to: self)
            case 2:
                let key = "favoriteButton"
                let favorite = UserDefaults.standard.string(forKey: "favoriteButton")
                let message = "Current".localized + " : \(favorite ?? "None".localized)\n\n" + "The information related to the set value is displayed first.".localized
                UIAlertController
                    .alert(title: "My Favorite Button".localized, message: message)
                    .defaultAction(title: Buttons.button4) { (action) in
                        UserDefaults.standard.set(Buttons.button4, forKey: key)
                    }
                    .defaultAction(title: Buttons.button5) { (action) in
                        UserDefaults.standard.set(Buttons.button5, forKey: key)
                    }
                    .defaultAction(title: Buttons.button6) { (action) in
                        UserDefaults.standard.set(Buttons.button6, forKey: key)
                    }
                    .defaultAction(title: Buttons.button8) { (action) in
                        UserDefaults.standard.set(Buttons.button8, forKey: key)
                    }
                    .cancelAction(title: "Cancel".localized)
                    .present(to: self)
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                if !Reachability.isConnectedToNetwork() {
                    presentNetworkAlert()
                } else {
                    self.present(RadioViewController.instantiate()!, animated: true, completion: nil)
                }
            case 1:
                sendEmail()
            case 2:
                let version = String(UserDefaults.standard.integer(forKey: "version"))
                guard let major = version.first?.description else { return }
                let minor = version[version.index(version.startIndex, offsetBy: 1)...version.index(version.startIndex, offsetBy: 2)].description
                let stringVersion = "\(major).\(minor)"
                let message = "PSN ID : Presto_95\n\nDJMAX RESPECT 1.16\nRespectU \(stringVersion)\n\nApp icon by icons8"
                UIAlertController
                    .alert(title: "CREDITS".localized, message: message)
                    .defaultAction(title: "Rate this app".localized) { [unowned self] (action) in
                        self.rateApp(appId: "id1291664067", completion: { (isSuccess) in
                            print("RateApp \(isSuccess)")
                        })
                    }
                    .cancelAction(title: "OK".localized)
                    .present(to: self)
            default:
                break
            }
        default:
            break
        }
    }
}

extension GuideViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 4, height: self.view.frame.width / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}


