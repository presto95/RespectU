//
//  SkillLevelDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

final class SkillLevelDetailViewController: UIViewController {
  
  @IBOutlet weak var button4BackgroundView: UIView!
  
  @IBOutlet weak var button5BackgroundView: UIView!
  
  @IBOutlet weak var button6BackgroundView: UIView!
  
  @IBOutlet weak var button8BackgroundView: UIView!
  
  private let skillLevelDetailView = "SkillLevelDetailView"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let button4View = UIView.instantiateFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
    guard let button5View = UIView.instantiateFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
    guard let button6View = UIView.instantiateFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
    guard let button8View = UIView.instantiateFromXib(xibName: skillLevelDetailView) as? SkillLevelDetailView else { return }
    let recordViews = [button4View, button5View, button6View, button8View]
    let backgroundViews = [button4BackgroundView!, button5BackgroundView!, button6BackgroundView!, button8BackgroundView!]
    let buttons = [Button.button4, Button.button5, Button.button6, Button.button8]
    for index in 0..<recordViews.count {
      let recordView = recordViews[index]
      let backgroundView = backgroundViews[index]
      recordView.frame.size = backgroundView.bounds.size
      backgroundView.addSubview(recordView)
      recordView.setProperties(button: buttons[index])
    }
  }
  
  @IBAction func didTouchUpShareButton(_ sender: UIButton) {
    let bounds = UIScreen.main.bounds
    UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
    self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
    guard let img = UIGraphicsGetImageFromCurrentImageContext() else { return }
    UIGraphicsEndImageContext()
    let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
    self.present(activityViewController, animated: true, completion: nil)
  }
  
  @IBAction func didTouchUpCancelButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}
