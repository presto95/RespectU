//
//  SearchByConditionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SearchRecordViewController: UIViewController {

    var selectedButton: Int = -1
    var selectedType: Int = -1
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var buttonByRate: UIButton!
    @IBOutlet weak var buttonByNote: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    var buttons = [UIButton?]()
    var types = [UIButton?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelFirst.text = "Select Button".localized
        labelSecond.text = "Select Search Type".localized
        buttonByRate.setTitle("Search by Rate".localized, for: .normal)
        buttonByNote.setTitle("Search by Note".localized, for: .normal)
        buttonSearch.setTitle("Enter all conditions".localized, for: .disabled)
        buttonSearch.setTitle("Search".localized, for: .normal)
        buttons = [button4, button5, button6, button8]
        types = [buttonByRate, buttonByNote]
        initializeButtons()
        initializeTypes()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickSearch(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Performance", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchRecordDetailViewController") as! SearchRecordDetailViewController
        controller.button = { () -> Int in
            for i in 0..<buttons.count {
                if(buttons[i]?.isSelected)!{
                    return i
                }
            }
            return -1
        }()
        controller.searchType = { () -> Int in
            for i in 0..<types.count{
                if(types[i]?.isSelected)!{
                    return i
                }
            }
            return -1
        }()
        if(buttonByRate.isSelected){
            let rateView = subView.subviews.first as! SearchByRateView
            controller.lowerRange = Double((rateView.lowerRate.text)!)!
            controller.upperRange = Double((rateView.upperRate.text)!)!
        } else {
            let noteView = subView.subviews.first as! SearchByNoteView
            controller.detailType = { () -> Int in
                if(noteView.buttonNoMCs.isSelected){
                    return 0
                } else {
                    return 1
                }
            }()
        }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickButtons(_ sender: UIButton) {
        initializeButtons()
        for button in buttons{
            button?.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.mainColor
        }
        switch(sender.tag){
        case 0:
            selectedButton = 0
        case 1:
            selectedButton = 1
        case 2:
            selectedButton = 2
        case 3:
            selectedButton = 3
        default:
            break
        }
        checkValidate()
    }
    
    @IBAction func clickTypes(_ sender: UIButton) {
        if(subView.subviews.first is SearchByRateView){
            
        } else if(subView.subviews.first is SearchByNoteView){
            (subView.subviews.first as! SearchByNoteView).selectedDetailNote = -1
        }
        if(subView.subviews.count != 0){
            subView.subviews.first?.removeFromSuperview()
        }
        initializeTypes()
        for type in types{
            type?.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.mainColor
        }
        switch(sender.tag){
        case 0:
            selectedType = 0
            let newView = SearchByRateView.instanceFromXib() as! SearchByRateView
            newView.frame.size = subView.frame.size
            newView.lowerRate.frame.origin.x = buttonByRate.frame.origin.x
            newView.lowerRate.frame.size = buttonByRate.frame.size
            newView.upperRate.frame.origin.x = buttonByNote.frame.origin.x
            newView.upperRate.frame.size = buttonByNote.frame.size
            newView.lowerRate.addTarget(self, action: #selector(endEdit), for: .editingDidEnd)
            newView.upperRate.addTarget(self, action: #selector(endEdit), for: .editingDidEnd)
            subView.addSubview(newView)
        case 1:
            selectedType = 1
            let newView = SearchByNoteView.instanceFromXib() as! SearchByNoteView
            newView.frame.size = subView.frame.size
            newView.buttonNoMCs.frame.origin.x = buttonByRate.frame.origin.x
            newView.buttonNoMCs.frame.size = buttonByRate.frame.size
            newView.buttonPPs.frame.origin.x = buttonByNote.frame.origin.x
            newView.buttonPPs.frame.size = buttonByNote.frame.size
            newView.buttonNoMCs.addTarget(self, action: #selector(clickNewViewButton), for: .touchUpInside)
            newView.buttonPPs.addTarget(self, action: #selector(clickNewViewButton), for: .touchUpInside)
            subView.addSubview(newView)
        default:
            break
        }
        checkValidate()
    }
    
    @objc func clickNewViewButton(_ sender: UIButton){
        checkValidate()
    }
    @objc func endEdit(_ sender: UITextField){
        checkValidate()
    }
    
    func initializeButtons(){
        for button in buttons{
            UIView.animate(withDuration: 0.3) {
                button?.backgroundColor = UIColor.subColor
            }
            button?.layer.borderColor = UIColor.mainColor.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    func initializeTypes(){
        for type in types{
            UIView.animate(withDuration: 0.3) {
                type?.backgroundColor = UIColor.subColor
            }
            type?.layer.borderColor = UIColor.mainColor.cgColor
            type?.layer.borderWidth = 2
        }
    }
    
    func checkValidate(){
        buttonSearch.isEnabled = false
        if(subView.subviews.first is SearchByRateView){
            let newView = subView.subviews.first as! SearchByRateView
            guard let lowerText = newView.lowerRate.text else { return }
            guard let upperText = newView.upperRate.text else { return }
            guard let lower = Double(lowerText) else { return }
            guard let upper = Double(upperText) else { return }
            if(upper < lower) { return }
            buttonSearch.isEnabled = true
        } else if(subView.subviews.first is SearchByNoteView){
            let newView = subView.subviews.first as! SearchByNoteView
            if(newView.selectedDetailNote != -1 && selectedType != -1 && selectedButton != -1){
                buttonSearch.isEnabled = true
            }
        } else {
            return
        }
    }
}
