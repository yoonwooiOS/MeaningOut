//
//  ProfileViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/9/24.
//

import Foundation

class ProfileNicknameSettingViewModel {
    
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
        
        inputNickName.bind { _ in
            self.validation()
        }
        inputSavedButtonClicked.bind { _ in
            guard let id = self.inputNickName.value else { return }
            if self.ouputValid.value {
                self.userJoinDate()
                self.user.nickName = id
            }
        }
        inputViewWillAppearTrigger.bind { value in
            guard let value else { return }
            print(self.user.profileImage, #function, "123123123")
            print(self.outputImage.value, #function)
            print("123213123")
            self.outputImage.value = self.user.profileImage
        }
        
        self.inputViewDidLoadTrigger.bind { value in
            guard let value else { return }
            self.outputRandomImage.value = ProfileImages().randomProfieImage
            self.user.profileImage = self.outputRandomImage.value
        }
//        self.inputProfileImageButtonclicked.bind { _ in
//            self.user.profileImage = self.outputRandomImage.value
//           
//        }
    }
    
     var isFormValid: Bool {
            return ouputValid.value
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
//        user.nickName = id
        
        
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
