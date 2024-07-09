//
//  ProfileViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/9/24.
//

import Foundation

class ProfileViewModel {
    
    var inpudId: Observable<String?> = Observable("")
   
    
    var outPutValid = Observable(false)
    var outPutValdationText = Observable("")
    
    init() {
        inpudId.bind { _ in
            self.validation()
        }
    }
    
    private func validation()  {
        guard let id = inpudId.value else { return }
        let regexNumber = "[0-9]"
        let isNumberContains = id.range(of: regexNumber, options: .regularExpression) != nil
        
        let regexSpecialCharacters = "[@#$%]"
        let ispecialCharactersContains = id.range(of: regexSpecialCharacters, options: .regularExpression) != nil
        
        guard id.count >= 2 && id.count <= 10 else {
            outPutValdationText.value = NickNameStringRawValues.isNotAllowedTextRange.rawValue
            outPutValid.value = false
            return
        }

        // MARK: 특수문자 입력 검증
        guard !ispecialCharactersContains else {
            outPutValdationText.value = NickNameStringRawValues.isUsedSpecialCharacters.rawValue
            outPutValid.value = false
            return
        }

        // MARK: 숫자 입력 검증
        guard !isNumberContains else {
            outPutValdationText.value = NickNameStringRawValues.isUsedNumber.rawValue
            outPutValid.value = false
            return
        }

        outPutValid.value = true
        outPutValdationText.value = NickNameStringRawValues.isValidate.rawValue
    }
}
