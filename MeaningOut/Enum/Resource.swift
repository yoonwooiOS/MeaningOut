//
//  Resource.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/13/24.
//

import UIKit

enum CustomColor {
    
    static let appPrimaryColor = UIColor(hex: "EF8947")
    static let black = UIColor(hex: "000000")
    static let white = UIColor(hex: "ffffff")
    static let gray = UIColor(hex: "828282")
    static let darkGray = UIColor(hex: "4C4C4C")
    static let lightGray = UIColor(hex: "CDCDCD")
    
    
}

enum CumstomFont {
    
    static let bold16 = UIFont.boldSystemFont(ofSize: 16)
    static let bold15 = UIFont.boldSystemFont(ofSize: 15)
    static let bold14 = UIFont.boldSystemFont(ofSize: 14)
    static let bold13 = UIFont.boldSystemFont(ofSize: 13)
    
    static let regular16 = UIFont.systemFont(ofSize: 16)
    static let regular15 = UIFont.systemFont(ofSize: 15)
    static let regular14 = UIFont.systemFont(ofSize: 14)
    static let regular13 = UIFont.systemFont(ofSize: 13)
    
}

enum Onboarding {
    
    enum Font {
        
        static let NoteworthyBold60 = UIFont(name: "Noteworthy-Bold", size: 60)
       
    }
    enum Color {
        
        static let appPrimaryColor = CustomColor.appPrimaryColor
        
    }
    
}

enum CirecleImage {
    
    static let size = 120
    
}

enum Label {
    
    enum Font {
        
       
        
    }
    
    enum Color {
        
        static let appPrimaryColor = CustomColor.appPrimaryColor

    }
    
    
    
}



enum NicknameState: String {
    
    case isNotAllowedTextRange = "2글자 이상 10글자 미만으로 설정 해주세요"
    case isUsedSpecialCharacters = "닉네임에 @,#,$,% 는 포함할 수 없어요"
    case isUsedNumber = "닉네임에 숫자는 포함할 수 없어요"
    case isValidate = "사용 가능한 닉네임 입니다"
}

