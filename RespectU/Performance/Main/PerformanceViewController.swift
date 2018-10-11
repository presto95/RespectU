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

class PerformanceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nicknameButton: UIButton!
    var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? Buttons.button4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SkillLevelCell", bundle: nil), forCellReuseIdentifier: "skillLevelCell")
        tableView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "summaryCell")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        API.requestVersions(completion: didReceiveVersions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentRateView()
    }
    
    func setup() {
        recordButton.setTitle("Performance Record".localized, for: .normal)
        self.favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? Buttons.button4
        self.nicknameButton.setTitle(UserDefaults.standard.string(forKey: "nickname") ?? "Nickname Setting".localized, for: [])
        self.tableView.reloadData()
    }
    
    @IBAction func didTouchUpNicknameButton(_ sender: UIButton) {
        let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
        if id.isEmpty {
            UIAlertController
                .alert(title: "", message: "Log In First.".localized)
                .action(title: "OK".localized)
                .present(to: self)
            return
        }
        let alert = UIAlertController.alert(title: "Nickname Setting".localized, message: "Enter your nickname.".localized)
        alert.textField { textField in
            textField.placeholder = "Nickname".localized
            }
            .action(title: "OK".localized) { [unowned self] _ in
                if let input = alert.textFields?.first?.text {
                    if !input.isEmpty {
                        API.uploadNickname(id: id, nickname: input, completion: self.didReceiveUploadNickname)
                        let nickname = input.trimmingCharacters(in: .whitespaces)
                        UserDefaults.standard.set(nickname, forKey: "nickname")
                        UserDefaults.standard.synchronize()
                        self.nicknameButton.setTitle(nickname, for: .normal)
                    }
                }
            }
            .action(.cancel, title: "Cancel".localized)
            .present(to: self)
    }
    
    @IBAction func didTouchUpNextButton(_ sender: UIButton) {
        guard let controller = UIViewController.instantiate(storyboard: "Guide", identifier: GuideViewController.classNameToString) as? GuideViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func didTouchUpRecordButton(_ sender: UIButton) {
        guard let controller = UIViewController.instantiate(storyboard: "Record", identifier: RecordViewController.classNameToString) as? RecordViewController else { return }
        self.present(controller, animated: true)
    }
}

// MARK: - Version
private extension PerformanceViewController {
    func didReceiveVersions(response: VersionResponse?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        guard let versionInfo = VersionInfo.fetch().first else { return }
        if version != response.clientVersion {
            DispatchQueue.main.async {
                UIAlertController
                    .alert(title: "", message: "New version released!\nPlease use it after updating.".localized)
                    .action(title: "Update".localized, handler: { _ in
                        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id1291664067") else { return }
                        guard #available(iOS 10, *) else {
                            UIApplication.shared.openURL(url)
                            return
                        }
                        UIApplication.shared.open(url, options: [:])
                    })
                    .action(.cancel, title: "Cancel".localized)
                    .present(to: self)
            }
        } else if response.serverVersion != versionInfo.serverVersion {
            DispatchQueue.main.async {
                UIAlertController
                    .alert(title: "", message: "There is new data.\nGo to \"Downloading from the server\" and update to the latest data.".localized)
                    .action(title: "OK".localized, handler: { [weak self] _ in
                        NotificationCenter.default.removeObserver(self as Any)
                        guard let controller = UIViewController.instantiate(storyboard: "Download", identifier: DownloadViewController.classNameToString) else { return }
                        self?.present(controller, animated: true, completion: {
                        })
                    })
                    .action(.cancel, title: "Cancel".localized)
                    .present(to: self)
            }
        }
    }
}
// MARK: - Nickname
private extension PerformanceViewController {
    func didReceiveUploadNickname(statusCode: Int?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let statusCode = statusCode else { return }
        if (200...299).contains(statusCode) {
            DispatchQueue.main.async {
                UIAlertController
                    .alert(title: "", message: "Succeeded to change nickname".localized)
                    .action(title: "OK".localized)
                    .present(to: self)
            }
        } else {
            DispatchQueue.main.async {
                UIAlertController
                    .alert(title: "", message: "Failed to change nickname".localized)
                    .action(title: "OK".localized)
                    .present(to: self)
            }
        }
    }
}
// MARK: - Ranking
extension PerformanceViewController {
    func didReceiveUploadRanking(statusCode: Int?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let statusCode = statusCode else { return }
        if (200...299).contains(statusCode) {
            DispatchQueue.main.async { [weak self] in
                guard let next = UIViewController.instantiate(storyboard: "Ranking", identifier: RankingViewController.classNameToString) else { return }
                self?.present(next, animated: true)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                UIAlertController
                    .alert(title: "", message: "Network Error".localized)
                    .action(title: "OK".localized)
                    .present(to: self)
            }
        }
    }
}

extension PerformanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "skillLevelCell", for: indexPath) as? SkillLevelCell else { return UITableViewCell() }
            cell.delegate = self
            cell.setProperties(favoriteButton, max: Skill.maxSkillPoint(button: favoriteButton), myRecord: Skill.mySkillPointAndHighestSeries(button: favoriteButton))
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? SummaryCell else { return UITableViewCell() }
            cell.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(UINib(nibName: "SummaryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "summaryCollectionCell")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.backgroundView?.backgroundColor = .main
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Skill Level".localized
        case 1:
            return "Summary".localized
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 1:
            return 130
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension PerformanceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            guard let controller = UIViewController.instantiate(storyboard: "Performance", identifier: SkillLevelDetailViewController.classNameToString) as? SkillLevelDetailViewController else { return }
            self.present(controller, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension PerformanceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCollectionCell", for: indexPath) as? SummaryCollectionCell else { return UICollectionViewCell() }
        cell.setProperties(NewRecordInfo.fetch(), at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
}

extension PerformanceViewController: SkillLevelCellDelegate {
    func didTouchUpCalculatorButton(_ sender: UIButton) {
        let alert = UIAlertController
            .alert(title: "Skill Point Calculator".localized, message: "")
            .textField { textField in
                textField.placeholder = "Difficulty".localized
                textField.keyboardType = .numberPad
            }
            .textField { textField in
                textField.placeholder = "Rate".localized
                textField.keyboardType = .decimalPad
        }
        alert.action(title: "\(Note.maxCombo) Failure".localized) { action in
            if let difficulty = Int(alert.textFields?.first?.text ?? ""), let rate = Double(alert.textFields?.last?.text ?? "") {
                let skillPoint = Skill.skillPoint(difficulty: difficulty, rate: rate, note: Note.none)
                UIAlertController
                    .alert(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                    .action(title: "OK".localized)
                    .present(to: self)
            } else {
                UIAlertController
                    .alert(title: "Error".localized, message: "Enter a valid value.".localized)
                    .action(title: "OK".localized)
                    .present(to: self)
            }
        }
        .action(title: "\(Note.maxCombo) / \(Note.perfectPlay)") { action in
            if let difficulty = Int(alert.textFields?.first?.text ?? ""), let rate = Double(alert.textFields?.last?.text ?? "") {
                if rate == 100 {
                    let skillPoint = Skill.skillPoint(difficulty: difficulty, rate: rate, note: Note.perfectPlay)
                    UIAlertController
                        .alert(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                        .action(title: "OK".localized)
                        .present(to: self)
                } else {
                    let skillPoint = Skill.skillPoint(difficulty: difficulty, rate: rate, note: Note.maxCombo)
                    UIAlertController
                        .alert(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                        .action(title: "OK".localized)
                        .present(to: self)
                }
            } else {
                UIAlertController
                    .alert(title: "Error".localized, message: "Enter a valid value.".localized)
                    .action(title: "OK".localized)
                    .present(to: self)
            }
        }
        .action(.cancel, title: "Cancel".localized)
        .present(to: self)
    }
    
    func didTouchUpRankingButton(_ sender: UIButton) {
        let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
        if id.isEmpty {
            UIAlertController
                .alert(title: "", message: "Log In First.".localized)
                .action(title: "OK".localized)
                .present(to: self)
        } else {
            let nickname = UserDefaults.standard.string(forKey: "nickname") ?? "noname"
            let button4SkillPoint = Skill.mySkillPointAndHighestSeries(button: Buttons.button4).sum
            let button5SkillPoint = Skill.mySkillPointAndHighestSeries(button: Buttons.button5).sum
            let button6SkillPoint = Skill.mySkillPointAndHighestSeries(button: Buttons.button6).sum
            let button8SkillPoint = Skill.mySkillPointAndHighestSeries(button: Buttons.button8).sum
            API.uploadRanking(id: id, nickname: nickname, button4: button4SkillPoint, button5: button5SkillPoint, button6: button6SkillPoint, button8: button8SkillPoint, completion: didReceiveUploadRanking)
        }
    }
    
    func didTouchUpTop50Button(_ sender: UIButton) {
        guard let controller = UIViewController.instantiate(storyboard: "Top50", identifier: Top50ViewController.classNameToString) as? Top50ViewController else { return }
        self.present(controller, animated: true)
    }
}

extension PerformanceViewController: SummaryCellDelegate {
    func didTouchUpDetailButton(_ sender: UIButton) {
        guard let controller = UIViewController.instantiate(storyboard: "Performance", identifier: SummaryDetailViewController.classNameToString) as? SummaryDetailViewController else { return }
        self.present(controller, animated: true)
    }
    
    func didTouchUpSearchButton(_ sender: UIButton) {
        guard let controller = UIViewController.instantiate(storyboard: "Performance", identifier: SearchRecordViewController.classNameToString) as? SearchRecordViewController else { return }
        self.present(controller, animated: true)
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
