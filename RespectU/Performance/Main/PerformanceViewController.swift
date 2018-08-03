//
//  PerformanceViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import RealmSwift
import StoreKit

class PerformanceViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nicknameButton: UIButton!
    var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SkillLevelCell", bundle: nil), forCellReuseIdentifier: "skillLevelCell")
        tableView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "summaryCell")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        recordButton.setTitle("Performance Record".localized, for: .normal)
        if Auth.auth().currentUser == nil {
            guard let loginViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
            self.present(loginViewController, animated: true)
        }
        if #available(iOS 10.3, *) {
            let appOpenCount = UserDefaults.standard.integer(forKey: "appOpenCount")
            UserDefaults.standard.set(appOpenCount + 1, forKey: "appOpenCount")
            if UserDefaults.standard.integer(forKey: "appOpenCount") % 3 == 0 {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
        self.tableView.reloadData()
        self.nicknameButton.setTitle(UserDefaults.standard.string(forKey: "nickname") ?? "Nickname Setting".localized, for: .normal)
    }
    
    static func instantiate() -> PerformanceViewController? {
        guard let viewController = UIStoryboard(name: "Performance", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? PerformanceViewController else { return nil }
        return viewController
    }
    
    @IBAction func touchUpNicknameButton(_ sender: UIButton) {
        let alert = UIAlertController.alert(title: "Nickname Setting".localized, message: "Enter your nickname.".localized)
        alert.textField { textField in
            textField.placeholder = "Nickname".localized
            }
            .defaultAction(title: "OK".localized) { [unowned self] action in
                if let input = alert.textFields?.first?.text {
                    if !input.isEmpty {
                        let nickname = input.trimmingCharacters(in: .whitespaces)
                        UserDefaults.standard.set(nickname, forKey: "nickname")
                        UserDefaults.standard.synchronize()
                        self.nicknameButton.setTitle(nickname, for: .normal)
                    }
                }
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(GuideViewController.instantiate()!, animated: true)
    }
    
    @IBAction func touchUpRecordButton(_ sender: UIButton) {
        self.present(RecordViewController.instantiate()!, animated: true)
    }
}

extension PerformanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillLevelCell") as! SkillLevelCell
            cell.delegate = self
            cell.setProperties(favoriteButton, max: Skill.maxSkillPoint(favoriteButton), my: Skill.mySkillPoint(button: favoriteButton))
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell") as! SummaryCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.backgroundView?.backgroundColor = UIColor.main
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Skill Level".localized
        case 1:
            return "Summary".localized
        case 2:
            return "Graph".localized
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
        case 2:
            return 40
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
            self.present(SkillLevelDetailViewController.instantiate()!, animated: true)
        default:
            break
        }
    }
}

extension PerformanceViewController: SkillLevelCellDelegate {
    func touchUpCalculatorButton(_ sender: UIButton) {
        let alert = UIAlertController
            .alert(title: "Skill Point Calculator".localized, message: "")
            .textField { textField in
                textField.placeholder = "Difficulty".localized
                textField.keyboardType = .numberPad
            }
            .textField { textField in
                textField.placeholder = "Rate".localized
                textField.keyboardType = .numberPad
        }
        alert.defaultAction(title: "\(Note.maxCombo) Failure".localized) { action in
            if let difficulty = Int(alert.textFields?.first?.text ?? ""), let rate = Double(alert.textFields?.last?.text ?? "") {
                let skillPoint = Skill.skillPoint(difficulty: difficulty, rate: "\(rate)", note: Note.none)
                UIAlertController
                    .alert(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                    .defaultAction(title: "OK".localized)
                    .present(to: self)
            } else {
                UIAlertController
                    .alert(title: "Error".localized, message: "Enter a valid value.".localized)
                    .defaultAction(title: "OK".localized)
                    .present(to: self)
            }
        }
            .defaultAction(title: "\(Note.maxCombo) / \(Note.perfectPlay)") { action in
                if let difficulty = Int(alert.textFields?.first?.text ?? ""), let rate = Double(alert.textFields?.last?.text ?? "") {
                    if rate == 100 {
                        let skillPoint = Skill.skillPoint(difficulty: difficulty, rate: "\(rate)", note: Note.perfectPlay)
                        UIAlertController
                            .alert(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                            .defaultAction(title: "OK".localized)
                            .present(to: self)
                    } else {
                        let skillPoint = Skill.skillPoint(difficulty: difficulty, rate: "\(rate)", note: Note.maxCombo)
                        UIAlertController
                            .alert(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                            .defaultAction(title: "OK".localized)
                            .present(to: self)
                    }
                } else {
                    UIAlertController
                        .alert(title: "Error".localized, message: "Enter a valid value.".localized)
                        .defaultAction(title: "OK".localized)
                        .present(to: self)
                }
        }
        
    }
    func touchUpTop50Button(_ sender: UIButton) {
        self.present(Top50ViewController.instantiate()!, animated: true)
    }
    func touchUpRankingButton(_ sender: UIButton) {
        if !Reachability.isConnectedToNetwork() {
            UIAlertController
                .alert(title: "Notice".localized, message: "Check your network status.".localized)
                .defaultAction(title: "OK".localized)
                .present(to: self)
        } else {
            UIAlertController
                .alert(title: "Ranking".localized, message: "")
                .defaultAction(title: "Ranking".localized) { action in
                    self.present(RankingViewController.instantiate()!, animated: true)
                }
                .defaultAction(title: "Upload".localized) { action in
                    Firebase.upload()
                }
                .cancelAction(title: "Cancel".localized)
                .present(to: self)
        }
    }
}
