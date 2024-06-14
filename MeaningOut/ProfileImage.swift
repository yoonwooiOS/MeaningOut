//
//  ProfileImage.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import Foundation

struct ProfileImage {
    
    let profileImage = ["profile_0","profile_1","profile_2","profile_3","profile_4","profile_5","profile_6","profile_7","profile_8","profile_9" ,"profile_10", "profile_11"]
    
    let randomImage: String?
    
    init() {
        self.randomImage = profileImage.randomElement()
        
        
    }
    
}
