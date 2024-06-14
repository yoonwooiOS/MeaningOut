//
//  PirmaryColorCircleImageView.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

class PirmaryColorCircleImageView: UIImageView {
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        image = UIImage(systemName: imageName)
        tintColor = .white
        contentMode = .center
        insetsLayoutMarginsFromSafeArea = true
        layer.borderColor = CustomColor.appPrimaryColor.cgColor
        layer.borderWidth = 3
        clipsToBounds = true
        backgroundColor = CustomColor.appPrimaryColor
        layer.cornerRadius = CGFloat(CirecleImage.size / 3 / 2)
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
