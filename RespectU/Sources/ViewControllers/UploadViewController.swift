//
//  SynchronizeViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SVProgressHUD
import SwiftKeychainWrapper

final class UploadViewController: UIViewController {
  
  private let apiService: APIServiceType = APIService()
  
  @IBOutlet private weak var uploadLabel: UILabel!
  
  @IBOutlet private weak var uploadButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    uploadLabel.text = L10n.storeRecordedPerformanceInformationOnTheServer
    uploadButton.setTitle(L10n.upload, for: [])
    uploadButton.addTarget(self, action: #selector(uploadButtonDidTap(_:)), for: .touchUpInside)
  }
  
  @objc func uploadButtonDidTap(_ sender: UIButton) {
    let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
    if id.isEmpty {
      UIAlertController
        .alert(title: "", message: L10n.logInFirst)
        .action(title: L10n.ok)
        .present(to: self)
    } else {
      let results = RecordInfo.fetch()
      var records = [RecordResponse.Record]()
      for result in results {
        let button4Normal = RecordResponse.Record.Button
          .Difficulty(rank: result.button4?.normal?.rank ?? "",
                      rate: result.button4?.normal?.rate ?? 0,
                      note: result.button4?.normal?.note ?? "")
        let button4Hard = RecordResponse.Record.Button
          .Difficulty(rank: result.button4?.hard?.rank ?? "",
                      rate: result.button4?.hard?.rate ?? 0,
                      note: result.button4?.hard?.note ?? "")
        let button4Maximum = RecordResponse.Record.Button
          .Difficulty(rank: result.button4?.maximum?.rank ?? "",
                      rate: result.button4?.maximum?.rate ?? 0,
                      note: result.button4?.maximum?.note ?? "")
        let button4 = RecordResponse.Record
          .Button(normal: button4Normal,
                  hard: button4Hard,
                  maximum: button4Maximum,
                  skillPoint: result.button4?.skillPoint ?? 0,
                  skillPointDifficulty: result.button4?.skillPointDifficulty ?? "",
                  skillPointNote: result.button4?.skillPointNote ?? "",
                  skillPointRate: result.button4?.skillPointRate ?? 0)
        let button5Normal = RecordResponse.Record.Button
          .Difficulty(rank: result.button5?.normal?.rank ?? "",
                      rate: result.button5?.normal?.rate ?? 0,
                      note: result.button5?.normal?.note ?? "")
        let button5Hard = RecordResponse.Record.Button
          .Difficulty(rank: result.button5?.hard?.rank ?? "",
                      rate: result.button5?.hard?.rate ?? 0,
                      note: result.button5?.hard?.note ?? "")
        let button5Maximum = RecordResponse.Record.Button
          .Difficulty(rank: result.button5?.maximum?.rank ?? "",
                      rate: result.button5?.maximum?.rate ?? 0,
                      note: result.button5?.maximum?.note ?? "")
        let button5 = RecordResponse.Record
          .Button(normal: button5Normal,
                  hard: button5Hard,
                  maximum: button5Maximum,
                  skillPoint: result.button5?.skillPoint ?? 0,
                  skillPointDifficulty: result.button5?.skillPointDifficulty ?? "",
                  skillPointNote: result.button5?.skillPointNote ?? "",
                  skillPointRate: result.button5?.skillPointRate ?? 0)
        let button6Normal = RecordResponse.Record.Button
          .Difficulty(rank: result.button6?.normal?.rank ?? "",
                      rate: result.button6?.normal?.rate ?? 0,
                      note: result.button6?.normal?.note ?? "")
        let button6Hard = RecordResponse.Record.Button
          .Difficulty(rank: result.button6?.hard?.rank ?? "",
                      rate: result.button6?.hard?.rate ?? 0,
                      note: result.button6?.hard?.note ?? "")
        let button6Maximum = RecordResponse.Record.Button
          .Difficulty(rank: result.button6?.maximum?.rank ?? "",
                      rate: result.button6?.maximum?.rate ?? 0,
                      note: result.button6?.maximum?.note ?? "")
        let button6 = RecordResponse.Record
          .Button(normal: button6Normal,
                  hard: button6Hard,
                  maximum: button6Maximum,
                  skillPoint: result.button6?.skillPoint ?? 0,
                  skillPointDifficulty: result.button6?.skillPointDifficulty ?? "",
                  skillPointNote: result.button6?.skillPointNote ?? "",
                  skillPointRate: result.button6?.skillPointRate ?? 0)
        let button8Normal = RecordResponse.Record.Button
          .Difficulty(rank: result.button8?.normal?.rank ?? "",
                      rate: result.button8?.normal?.rate ?? 0,
                      note: result.button8?.normal?.note ?? "")
        let button8Hard = RecordResponse.Record.Button
          .Difficulty(rank: result.button8?.hard?.rank ?? "",
                      rate: result.button8?.hard?.rate ?? 0,
                      note: result.button8?.hard?.note ?? "")
        let button8Maximum = RecordResponse.Record.Button
          .Difficulty(rank: result.button8?.maximum?.rank ?? "",
                      rate: result.button8?.maximum?.rate ?? 0,
                      note: result.button8?.maximum?.note ?? "")
        let button8 = RecordResponse.Record
          .Button(normal: button8Normal,
                  hard: button8Hard,
                  maximum: button8Maximum,
                  skillPoint: result.button8?.skillPoint ?? 0,
                  skillPointDifficulty: result.button8?.skillPointDifficulty ?? "",
                  skillPointNote: result.button8?.skillPointNote ?? "",
                  skillPointRate: result.button8?.skillPointRate ?? 0)
        let title = LanguageResponse(english: result.title?.english ?? "",
                                     korean: result.title?.korean)
        let record = RecordResponse.Record(title: title,
                                           series: result.series,
                                           button4: button4,
                                           button5: button5,
                                           button6: button6,
                                           button8: button8)
        records.append(record)
      }
      let recordResponse = RecordResponse(id: id, records: records)
      guard let uploadData = try? JSONEncoder().encode(recordResponse) else { return }
      SVProgressHUD.show()
      apiService.uploadRecords(uploadData) { statusCode, error in
        if let error = error {
          self.present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
          return
        }
        guard let statusCode = statusCode else { return }
        if (200...299).contains(statusCode) {
          self.presentSuccessAlert()
        } else {
          self.presentFailureAlert()
        }
      }
    }
  }
  
  @IBAction func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Private Method

private extension UploadViewController {
  
  func presentSuccessAlert() {
    DispatchQueue.main.async { [weak self] in
      SVProgressHUD.dismiss()
      UIAlertController
        .alert(title: "", message: L10n.yourDataHasBeenSuccessfullyUploaded)
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
  
  func presentFailureAlert() {
    DispatchQueue.main.async { [weak self] in
      SVProgressHUD.dismiss()
      UIAlertController
        .alert(title: "", message: L10n.networkError)
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
}
