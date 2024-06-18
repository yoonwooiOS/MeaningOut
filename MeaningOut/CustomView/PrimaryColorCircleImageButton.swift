//
//  PrimaryColorCircleImageButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit


class PrimaryColorCircleImageButton: UIButton {
    
    init(imageName: String, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        
        setImage(UIImage(named: imageName), for: .normal)
        contentMode = .scaleToFill
        
        layer.cornerRadius = CGFloat( cornerRadius / 2)
        layer.masksToBounds = true
        
        layer.borderWidth = 3
        layer.borderColor = CustomColor.appPrimaryColor.cgColor
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

