//
//  ProfileImageSettingCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileImageSettingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileImageSettingCollectionViewCell"
    
    let profileImage = PrimaryColorCircleImageButton(imageName: "")
    
    override init(frame: CGRect) {
        
        super.init(frame: frame )
        
       
        contentView.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

    

