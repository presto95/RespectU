//
//  GuideViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import MessageUI
import PMAlertController
import Firebase
import GoogleSignIn

class GuideViewController: UIViewController, GIDSignInUIDelegate {

    let imageNames = [["song", "mission", "trophy", "achievement", "tip"], ["log", "bpmDefault", "favoriteButton"], ["radio", "email", "credit"]]
    let sectionHeaderTitles = ["Guide for DJMAX RESPECT", "Personal Setting", "More"]
    let cellTitles = [["Music", "Mission", "Trophy", "Achievement", "TIP"], ["Login / Logout", "BPM Default Setting", "My Favorite Button"], ["DJMAX Radio Station", "Send Email to Developer", "Credit"]]
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonPerformance: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        collectionView.register(UINib(nibName: "GuideCell", bundle: nil), forCellWithReuseIdentifier: "guideCell")
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 3)
        layout.minimumLineSpacing = 5
        layout.minimumLineSpacing = 5
        layout.headerReferenceSize = CGSize(width: 50, height: 30)
        collectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToPrevious(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func recordPerformance(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
        present(controller, animated: true, completion: nil)
    }
    private func goToAnotherView(storyboard: String, identifier: String){
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        present(controller, animated: true, completion: nil)
        
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["yoohan95@gmail.com"])
            present(mail, animated: true)
        }
    }
}

extension GuideViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension GuideViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guideCell", for: indexPath) as! GuideCell
        cell.layer.borderColor = UIColor.mainColor.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        cell.label.text = cellTitles[indexPath.section][indexPath.row].localized
        cell.image.image = UIImage(imageLiteralResourceName: imageNames[indexPath.section][indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 5
        case 1:
            return 3
        case 2:
            return 3
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "guideSection", for: indexPath) as! GuideReusableView
        sectionHeader.sectionTitle.text = sectionHeaderTitles[indexPath.section].localized
        return sectionHeader
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
}

extension GuideViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? GuideCell{
                cell.contentView.backgroundColor = UIColor.mainColor
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? GuideCell{
                cell.contentView.backgroundColor = UIColor.subColor
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch(indexPath.section){
        case 0:
            switch(indexPath.row){
            case 0:
                goToAnotherView(storyboard: "Song", identifier: "SongViewController")
            case 1:
                goToAnotherView(storyboard: "Mission", identifier: "MissionViewController")
            case 2:
                goToAnotherView(storyboard: "Trophy", identifier: "TrophyViewController")
            case 3:
                goToAnotherView(storyboard: "Achievement", identifier: "AchievementViewController")
            case 4:
                goToAnotherView(storyboard: "Tip", identifier: "TipViewController")
            default:
                break
            }
        case 1:
            switch(indexPath.row){
            case 0:
                if(Auth.auth().currentUser == nil){
                    GIDSignIn.sharedInstance().signIn()
                    let alert = PMAlertController.showOKButton(title: "Notice".localized, message: "You have been logged in.".localized)
                    present(alert, animated: true)
                } else {
                    do {
                        try Auth.auth().signOut()
                    } catch { print("logout error") }
                    let alert = PMAlertController.showOKButton(title: "Notice".localized, message: "You have been logged out.".localized)
                    self.present(alert, animated: true)
                }
            case 1:
                let alert = PMAlertController.showBPMDefault()
                present(alert, animated: true)
            case 2:
                let alert = PMAlertController.showFavoriteButtonSetting()
                present(alert, animated: true)
            default:
                break
            }
        case 2:
            switch(indexPath.row){
            case 0:
                goToAnotherView(storyboard: "Radio", identifier: "RadioViewController")
            case 1:
                sendEmail()
            case 2:
                let message = "PSN ID : Presto_95\n\nDJMAX RESPECT 1.11\nRespectU 2.00\n\nApp icon by icons8"
                let alert = PMAlertController.showOKButton(title: "CREDITS".localized, message: message)
                present(alert, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}


