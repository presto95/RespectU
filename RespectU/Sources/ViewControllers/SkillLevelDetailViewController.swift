//
//  SkillLevelDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The skill level detail view controller.
final class SkillLevelDetailViewController: UIViewController {
  
  /// The background view for the 4B.
  @IBOutlet private weak var button4BackgroundView: UIView!
  
  /// The background view for the 5B.
  @IBOutlet private weak var button5BackgroundView: UIView!
  
  /// The background view for the 6B.
  @IBOutlet private weak var button6BackgroundView: UIView!
  
  /// The background view for the 8B.
  @IBOutlet private weak var button8BackgroundView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  private func configure() {
    guard let button4View
      = UIView.instantiateFromXib(xibName: SkillLevelDetailView.name) as? SkillLevelDetailView
      else { return }
    guard let button5View
      = UIView.instantiateFromXib(xibName: SkillLevelDetailView.name) as? SkillLevelDetailView
      else { return }
    guard let button6View
      = UIView.instantiateFromXib(xibName: SkillLevelDetailView.name) as? SkillLevelDetailView
      else { return }
    guard let button8View
      = UIView.instantiateFromXib(xibName: SkillLevelDetailView.name) as? SkillLevelDetailView
      else { return }
    let recordViews = [button4View, button5View, button6View, button8View]
    let backgroundViews = [
      button4BackgroundView,
      button5BackgroundView,
      button6BackgroundView,
      button8BackgroundView
      ].compactMap { $0 }
    let buttons: [Button] = [.button4, .button5, .button6, .button8]
    recordViews.indices.forEach { index in
      let recordView = recordViews[index]
      let backgroundView = backgroundViews[index]
      recordView.frame.size = backgroundView.bounds.size
      backgroundView.addSubview(recordView)
      recordView.configure(with: buttons[index])
    }
  }
  
  @IBAction private func shareButtonDidTap(_ sender: UIButton) {
    UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, true, 0.0)
    view.drawHierarchy(in: UIScreen.main.bounds, afterScreenUpdates: false)
    guard let img = UIGraphicsGetImageFromCurrentImageContext() else { return }
    UIGraphicsEndImageContext()
    let activityViewController = UIActivityViewController(activityItems: [img],
                                                          applicationActivities: nil)
    present(activityViewController, animated: true, completion: nil)
  }
  
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
