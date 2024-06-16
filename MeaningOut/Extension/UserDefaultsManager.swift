//
//  UserDefaultsManager.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import Foundation

class UserDefaultsManager {
    
    var nickname:String {
        get {
            return UserDefaults.standard.string(forKey: "nickname") ?? "손님"
        } set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
        
    }
    
    var profileImage: String {
        get {
            return UserDefaults.standard.string(forKey: "profileImage") ?? "닉네임을 입력해주세요 :)"
        } set {
            UserDefaults.standard.set(newValue, forKey: "profileImage")
        }
        
    }
    
}
