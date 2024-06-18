//
//  User.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import Foundation

struct User {
    static var nickName: String {
        get {
            return UserDefaultsManager().nickname
        }
        set {
            var ud = UserDefaultsManager()
            ud.nickname = newValue
        }
    }
    
    static var selectedProfileImage: String {
        
        get {
            return UserDefaultsManager().profileImage
        }
        set {
            var ud = UserDefaultsManager()
            ud.profileImage = newValue
        }
        
    }
    static var savedRecentSearchList: [String] {
            get {
                return UserDefaultsManager().recentSearchList
            }
            set {
                var ud = UserDefaultsManager()
                ud.recentSearchList = newValue
            }
        }
    let isLiked: Bool
    
    static var joinDate: String {
        
        get {
            return UserDefaultsManager().joinDate
        }
        set {
            var ud = UserDefaultsManager()
            ud.joinDate = newValue
        }
        
        
        
    }
    static let shoppingList: [String]? = nil
}
