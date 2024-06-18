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
            return UserDefaults.standard.string(forKey: "nickname") ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
        
    }
    
    var profileImage: String {
        get {
            return UserDefaults.standard.string(forKey: "profileImage") ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: "profileImage")
        }
        
    }
    
    
    var recentSearchList: [String] {
        get {
            return (UserDefaults.standard.array(forKey: "recentSearchList")  as? [String]) ?? []
        } set {
            UserDefaults.standard.set(newValue, forKey: "recentSearchList")
        }
        
    }
    
    var joinDate: String {
        get {
            return UserDefaults.standard.string(forKey: "joinDate") ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: "joinDate")
        }
        
    }
    
}
