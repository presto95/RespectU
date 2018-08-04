//
//  Firebase.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

class Firebase {
    static func fetch(_ key: String) {
        var userIds = [String]()
        var values = [Double]()
        let ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value) { snapshot in
            var dic = [String: Double]()
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else { return }
                for child in snap.children {
                    guard let snap = child as? DataSnapshot else { return }
                    if snap.key == "userId" {
                        guard let userId = snap.value as? String else { return }
                        userIds.append(userId)
                    }
                    if snap.key == key {
                        guard let value = snap.value as? Double else { return }
                        values.append(value)
                    }
                }
            }
            for index in 0..<userIds.count {
                dic[userIds[index]] = values[index]
            }
            let sortedDic = dic.sorted { $0.value > $1.value }
            NotificationCenter.default.post(name: .didReceiveFirebaseFetch, object: nil, userInfo: ["dictionary": sortedDic])
        }
    }
    
    static func upload() {
        let button4SkillPoint = Skill.mySkillPoint(button: Buttons.button4).sum
        let button5SkillPoint = Skill.mySkillPoint(button: Buttons.button5).sum
        let button6SkillPoint = Skill.mySkillPoint(button: Buttons.button6).sum
        let button8SkillPoint = Skill.mySkillPoint(button: Buttons.button8).sum
        var perfectCount = 0
        let results = RecordInfo.get()
        let difficulties = ["nm", "hd", "mx"]
        let buttons = [4, 5, 6, 8]
        for result in results {
            for difficulty in difficulties {
                for button in buttons {
                    let key = "\(difficulty)\(button)Note"
                    let value = result.value(forKey: key) as? String ?? Note.none
                    if value == Note.perfectPlay {
                        perfectCount += 1
                    }
                }
            }
        }
        let uid = Auth.auth().currentUser?.uid ?? ""
        let email = Auth.auth().currentUser?.email ?? ""
        Database.database().reference().child("users").child(uid).setValue([
            "userId": UserDefaults.standard.string(forKey: "nickname") ?? email,
            Skill.button4SkillPoint: (button4SkillPoint * 100).rounded() / 100,
            Skill.button5SkillPoint: (button5SkillPoint * 100).rounded() / 100,
            Skill.button6SkillPoint: (button6SkillPoint * 100).rounded() / 100,
            Skill.button8SkillPoint: (button8SkillPoint * 100).rounded() / 100,
            "countPerfectPlay": perfectCount,
            "uid": uid
            ])
    }
}
