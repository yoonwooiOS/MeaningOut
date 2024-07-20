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
    static let blackAlpah50 = UIColor(hex: "000000", alpha: 0.5)
    static let white = UIColor(hex: "ffffff")
    static let gray = UIColor(hex: "828282")
    static let grayAlpha50 = UIColor(hex: "828282", alpha: 0.5)
    static let darkGray = UIColor(hex: "4C4C4C")
    static let lightGray = UIColor(hex: "CDCDCD")
    
    
}

enum CustomFont {
    
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

enum PrimaryCircleSize {
    
    static let size = CGFloat(120)
    
}

enum GrayCircleSize {
    static let sectionSpacing: CGFloat = 20
    static let cellSpacing: CGFloat = 16
    static let width = UIScreen.main.bounds.width - (GrayCircleSize.sectionSpacing * 3 ) - (GrayCircleSize.cellSpacing * 4)
    static let height = GrayCircleSize.width / 4 * 1.3
    
}

enum UserProfileImageGrayCircleSize {
    
    static let size = CGFloat(100)
    
}

enum SearchResultCell {
    
    static let sectionSpacing: CGFloat = 5
    static let cellSpacing: CGFloat = 10
    static let width = UIScreen.main.bounds.width -  (SearchResultCell.cellSpacing * 2)
    static let height = (SearchResultCell.width / 2) * 1.5
    
}



enum NickNameStringRawValues: String {
    
    case isNotAllowedTextRange = "2글자 이상 10글자 미만으로 설정 해주세요"
    case isUsedSpecialCharacters = "닉네임에 @,#,$,% 는 포함할 수 없어요"
    case isUsedNumber = "닉네임에 숫자는 포함할 수 없어요"
    case isValidate = "사용 가능한 닉네임 입니다"
    case isValidate2 = "사용 가능한 닉네임 입니다 :D"
}

enum NicknameStates: Error {
    
    case isNotAllowedTextRange
    case isUsedSpecialCharacters
    case isUsedNumber
    case isValidate
    case isValidate2
}

                                                  
enum SearchSorted: String {
    case sim 
    case date
    case asc
    case dsc
    
}

enum filterdButton: Int {
    case accuracy
    case date
    case asc
    case dsc
    

}
