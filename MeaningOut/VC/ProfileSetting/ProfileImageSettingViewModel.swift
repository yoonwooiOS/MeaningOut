//
//  ProfileImageSettingViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/15/24.
//

import Foundation

class ProfileImageSettingViewModel {
    
    var user = User.shared
    var inputSelectedImage: Observable<String?> = Observable(nil)
    var viewWillDisappearTrigger: Observable<Void?> = Observable(nil)
    var profieImage: Observable<String?> = Observable(nil)
    var outputProfileImageList = ProfileImages().profileImageName
    var inputViewDidloadTrigger: Observable<Void?> = Observable(nil)
    init() {
        
        profieImage.bind { _ in
            self.profieImage.value = self.user.profileImage
        }
        
        viewWillDisappearTrigger.bind { value in
            guard let value else { return }
            guard let image = self.inputSelectedImage.value else {
                print("디스어피어 트리거")
                return }
            self.user.profileImage = image
            print("디스어피어 트리거",self.user.profileImage )
           
        }
        inputViewDidloadTrigger.bind { value in
            guard let value else { return }
            self.profieImage.value = self.user.profileImage
        }
        
       
        }
    
    func updateProfileImage() {
        guard let image = self.inputSelectedImage.value else { return }
        user.profileImage = image
        print(#function)
    }
}
