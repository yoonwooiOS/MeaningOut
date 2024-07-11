//
//  ProfileViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/9/24.
//

import Foundation

class ProfileViewModel {
    
    var user = Users.shared
    var inputNickName: Observable<String?> = Observable("")
    var inputSavedButtonClicked: Observable<Void?> = Observable(nil)
    var outPutValid = Observable(false)
    var outPutValdationNickName = Observable("")
   
    
    init() {
        inputNickName.bind { _ in
            self.validation()
        }
        inputSavedButtonClicked.bind { _ in
            guard let id = self.inputNickName.value else { return }
            if self.outPutValid.value {
                
            }
        }
    }
    
    var isFormValid: Bool {
            return outPutValid.value
        }
    private func validation()  {
        guard let id = inputNickName.value else { return }
        let regexNumber = "[0-9]"
        let isNumberContains = id.range(of: regexNumber, options: .regularExpression) != nil
        let regexSpecialCharacters = "[@#$%]"
        let ispecialCharactersContains = id.range(of: regexSpecialCharacters, options: .regularExpression) != nil
        
        guard id.count >= 2 && id.count <= 10 else {
            outPutValdationNickName.value = NickNameStringRawValues.isNotAllowedTextRange.rawValue
            outPutValid.value = false
            return
        }

        // MARK: 특수문자 입력 검증
        guard !ispecialCharactersContains else {
            outPutValdationNickName.value = NickNameStringRawValues.isUsedSpecialCharacters.rawValue
            outPutValid.value = false
            return
        }

        // MARK: 숫자 입력 검증
        guard !isNumberContains else {
            outPutValdationNickName.value = NickNameStringRawValues.isUsedNumber.rawValue
            outPutValid.value = false
            return
        }

        outPutValid.value = true
        outPutValdationNickName.value = NickNameStringRawValues.isValidate.rawValue
        user.nickName = id
        
        
    }
    
    private func userJoinDate() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: currentDate)
        
        user.joinDate = currentDateString
        
    }
    
}
