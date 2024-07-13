//
//  User.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import Foundation

class User {
    static let shared = User()
    let ud = UserDefaultsManager.shared
    
    private init() {
        if ud.profileImage.isEmpty {
            ud.profileImage = ProfileImages().randomProfieImage
        }
    }
    
    var nickName: String {
        get {
            return ud.nickname
        }
        set {
            ud.nickname = newValue
        }
    }
    
    var profileImage: String {
        
        get {
            return ud.profileImage
        }
        set {
            ud.profileImage = newValue
        }
        
    }
    var savedRecentSearchList: [String] {
        get {
            return ud.recentSearchList
        }
        set {
            ud.recentSearchList = newValue
        }
    }
    
    var isLiked: Bool?
    
    var joinDate: String {
        
        get {
            return ud.joinDate
        }
        set {
            ud.joinDate = newValue
        }
    }
    var shoppingList: [String] {
        
        get {
            return ud.shoppingList
        }
        set {
            ud.shoppingList = newValue
        }
    }
    var likedProductList: [String] {
        
        get {
            return ud.shoppingList
        }
        set {
            ud.shoppingList = newValue
        }
    }
}
