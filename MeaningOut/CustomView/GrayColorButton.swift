//
//  GrayColorButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

class GrayColorButton: UIButton {
    
    init(title: String, backgroundColor bcColor: UIColor, tintcolor: UIColor) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
       
        setTitleColor(CustomColor.black, for: .normal)
        
        
        titleLabel?.font = CustomFont.bold13
        setTitleColor(tintcolor, for: .normal) 
        backgroundColor = bcColor
        
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
