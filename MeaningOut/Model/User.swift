//
//  User.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import Foundation

struct User {
    static var nickName: String? = UserDefaults.standard.string(forKey: "nickname")
    static var selectedProfileImage: String = ""
    static var recentSearchList: [String]? = ["dasd","asdsad"]
    let bookMark: Bool
    let joinDate: String
    static let shoppingList: [String]? = nil
}
