//
//  PrimaryColorButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

class PrimaryColorButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        setTitleColor(CustomColor.white, for: .normal)
        
        
        titleLabel?.font = CustomFont.bold16
        
        backgroundColor = CustomColor.appPrimaryColor
        
        layer.cornerRadius = 20
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
