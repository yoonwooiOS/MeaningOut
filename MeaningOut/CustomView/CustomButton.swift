//
//  CustomButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit

class CustomButton: UIButton {
    
    init(tintcolor: UIColor, backgourndColor bgColor: UIColor) {
        super.init(frame: .zero)
        
       
        
        titleLabel?.font = CustomFont.bold13
        setTitleColor(tintcolor, for: .normal)
        backgroundColor = bgColor
        
        layer.borderColor = CustomColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 16
        
      
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
