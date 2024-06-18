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
    
    
    var profileImageButton = GrayColorCircleButton(imageName: "profile_0")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        
        profileImageButton.isUserInteractionEnabled = false
        setUpHierarchy()
        setUpLayout()
    }
    
    private func setUpHierarchy() {
        contentView.addSubview(profileImageButton)
        
        
    }
    
    private func setUpLayout() {
        
        profileImageButton.snp.makeConstraints {
            
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
            
        }
        
    }
    
    func setUpCell(data: String) {
//         print(data,"1111")
         profileImageButton.setImage(UIImage(named: data), for: .normal)
       
        
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            
            profileImageButton.alpha = 0.5
            profileImageButton.layer.borderWidth = 1
            profileImageButton.layer.borderColor = CustomColor.gray.cgColor
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

    

