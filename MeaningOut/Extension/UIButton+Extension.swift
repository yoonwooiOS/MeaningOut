//
//  UIButton+Extension.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit

extension UIButton {
    
    func grayButton() {
        
        
        self.titleLabel?.font = CustomFont.bold13
        self.setTitleColor(CustomColor.white, for: .normal)
        self.backgroundColor = CustomColor.gray
        
        self.layer.borderColor = CustomColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 16
        
        
    }
    
    func whiteButton() {
        
        self.titleLabel?.font = CustomFont.bold13
        self.setTitleColor(CustomColor.black, for: .normal)
        self.backgroundColor = CustomColor.white
        
        self.layer.borderColor = CustomColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 16
        
        
        
    }
    
}

extension UIButton.Configuration {
    
    static func BookMarkImageButton() -> UIButton.Configuration {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "18개의 상품"
        
        configuration.cornerStyle = .capsule
        configuration.titleAlignment = .trailing
        
        configuration.baseBackgroundColor = CustomColor.white
        configuration.baseForegroundColor = CustomColor.black
        configuration.image = UIImage(systemName: "bag")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        
        return configuration
    }
    
    
}
