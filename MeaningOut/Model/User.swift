//
//  User.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import Foundation

class Users {
    
    static let shared = Users()
    let ud = UserDefaultsManager()
    private init() { }
    
    var nickName: String? {
        didSet {
            saveNickName()
        }
    }
    
    var joinDate: String? {
        didSet {
            saveJoinDate()
        }
    }
    
    var profileImage: String = ProfileImages().randomProfieImage {
        didSet {
            saveProfileImage()
        }
    }
    
    private func saveNickName() {
        ud.nickname = self.nickName ?? ""
    }
    
    private func saveProfileImage() {
        ud.profileImage = self.profileImage
    }
    
    private func saveJoinDate() {
        ud.joinDate = self.joinDate ?? ""
    }
}


struct User {
    
    static var nickName: String {
        get {
            return UserDefaultsManager().nickname
        }
        set {
            let ud = UserDefaultsManager()
            ud.nickname = newValue
        }
    }
    
    static var selectedProfileImage: String {
        
        get {
            return UserDefaultsManager().profileImage
        }
        set {
            let ud = UserDefaultsManager()
            ud.profileImage = newValue
        }
        
    }
    static var savedRecentSearchList: [String] {
            get {
                return UserDefaultsManager().recentSearchList
            }
            set {
                let ud = UserDefaultsManager()
                ud.recentSearchList = newValue
            }
        }
    let isLiked: Bool
    
    static var joinDate: String {
        
        get {
            return UserDefaultsManager().joinDate
        }
        set {
            let ud = UserDefaultsManager()
            ud.joinDate = newValue
        }
        
        
        
    }
    static var shoppingList: [String] {
        
        get {
            return UserDefaultsManager().shoppingList
        }
        set {
            let ud = UserDefaultsManager()
            ud.shoppingList = newValue
        }
        
        
        
    }
    
    
    static var likedProductList: [String] {
        
        get {
            return UserDefaultsManager().shoppingList
        }
        set {
            let ud = UserDefaultsManager()
            ud.shoppingList = newValue
        }
    }
}
