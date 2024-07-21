//
//  ProfileViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/9/24.
//

import Foundation

final class ProfileNicknameSettingViewModel {
    
    var user = User.shared
    var inputNickName: Observable<String?> = Observable("")
    var inputSavedButtonClicked: Observable<Void?> = Observable(nil)
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputProfileImageButtonclicked: Observable<Void?> = Observable(nil)
    var ouputValid = Observable(false)
    var outputValdationNickName = Observable("")
    var outputRandomImage =  Observable(ProfileImages().randomProfieImage)
    var outputImage:Observable<String?> = Observable(nil)
    
    init() {
        transform()
    }
    var isFormValid: Bool {
           return ouputValid.value
       }
    private func transform() {
        inputNickName.bind { [weak self] value in
            guard value != nil, let self else { return }
            self.validation()
        }
        inputSavedButtonClicked.bind { [weak self] value in
            guard let self , let id = self.inputNickName.value else { return }
            if self.ouputValid.value {
                self.userJoinDate()
                self.user.nickName = id
            }
        }
        inputViewWillAppearTrigger.bind { [weak self] value in
            guard let value, let self else { return }
            self.outputImage.value = self.user.profileImage
        }
        inputViewDidLoadTrigger.bind { [weak self] value in
            guard let value, let self else { return }
            self.outputRandomImage.value = ProfileImages().randomProfieImage
            self.user.profileImage = self.outputRandomImage.value
        }
    }
     
    private func validation()  {
        guard let id = inputNickName.value else { return }
        let regexNumber = "[0-9]"
        let isNumberContains = id.range(of: regexNumber, options: .regularExpression) != nil
        let regexSpecialCharacters = "[@#$%]"
        let ispecialCharactersContains = id.range(of: regexSpecialCharacters, options: .regularExpression) != nil
        
        guard id.count >= 2 && id.count <= 10 else {
            outputValdationNickName.value = NickNameStringRawValues.isNotAllowedTextRange.rawValue
            ouputValid.value = false
            return
        }
        // MARK: 특수문자 입력 검증
        guard !ispecialCharactersContains else {
            outputValdationNickName.value = NickNameStringRawValues.isUsedSpecialCharacters.rawValue
            ouputValid.value = false
            return
        }
        // MARK: 숫자 입력 검증
        guard !isNumberContains else {
            outputValdationNickName.value = NickNameStringRawValues.isUsedNumber.rawValue
            ouputValid.value = false
            return
        }
        ouputValid.value = true
        outputValdationNickName.value = NickNameStringRawValues.isValidate.rawValue
    }
    
    private func updateImage() {
        self.outputImage.value = self.user.profileImage
    }

    private func userJoinDate() {
        let joinDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: joinDate)
        
        user.joinDate = currentDateString
    }
}
