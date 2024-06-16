//
//  GrayColorCircleButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/15/24.
//

import UIKit


class GrayColorCircleButton: UIButton {
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        
        setImage(UIImage(named: imageName), for: .normal)
        contentMode = .scaleToFill
        
//
        layer.cornerRadius =  CGFloat(GrayCircleSize.height / 2.5)
        layer.masksToBounds = true
        layer.borderColor = CustomColor.gray.cgColor
        alpha = 0.5
        layer.borderWidth = 1
       
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


