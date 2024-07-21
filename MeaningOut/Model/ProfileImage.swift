//
//  ProfileImage.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import Foundation

struct ProfileImages {
    let profileImageName: [String] = [
    "profile_0", "profile_1", "profile_2", "profile_3", "profile_4",
    "profile_5", "profile_6", "profile_7", "profile_8", "profile_9",
    "profile_10", "profile_11"
]
    var randomProfieImage: String {
        return profileImageName.randomElement() ?? "profile_0"
    }
}
