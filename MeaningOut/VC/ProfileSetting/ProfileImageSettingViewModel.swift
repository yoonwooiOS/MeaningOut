//
//  ProfileImageSettingViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/15/24.
//

import Foundation

final class ProfileImageSettingViewModel {
    
    var user = User.shared
    var inputSelectedImage: Observable<String?> = Observable(nil)
    var viewWillDisappearTrigger: Observable<Void?> = Observable(nil)
    var profieImage: Observable<String?> = Observable(nil)
    var outputProfileImageList = ProfileImages().profileImageName
    var inputViewDidloadTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        profieImage.bind { [weak self] value in
            guard let self, value != nil else { return }
            self.profieImage.value = self.user.profileImage
        }
        viewWillDisappearTrigger.bind { [weak self] value in
            guard let value, let self else { return }
            guard let image = self.inputSelectedImage.value else { return }
            self.user.profileImage = image
        }
        inputViewDidloadTrigger.bind { [weak self] value in
            guard let value, let self else { return }
            self.profieImage.value = self.user.profileImage
        }
    }
    
    func updateProfileImage() {
        guard let image = self.inputSelectedImage.value else { return }
        user.profileImage = image
        print(#function)
    }
}
