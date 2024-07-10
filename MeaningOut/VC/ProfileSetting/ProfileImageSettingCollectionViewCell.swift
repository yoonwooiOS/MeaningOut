//
//  ProfileImageSettingCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import SnapKit

final class ProfileImageSettingCollectionViewCell: BaseCollectionViewCell {
    
    var profileImageButton = {
        let button = GrayColorCircleButton(imageName: "profile_0")
        button.isUserInteractionEnabled = false
        return button
    }()
    
     override func setUpHierarchy() {
        contentView.addSubview(profileImageButton)
    }
    
     override func setUpLayout() {
        profileImageButton.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func setUpCell(data: String) {
         profileImageButton.setImage(UIImage(named: data), for: .normal)
        
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            profileImageButton.alpha = 0.5
            profileImageButton.layer.borderWidth = 1
            profileImageButton.layer.borderColor = CustomColor.gray.cgColor
        } 
}

    

