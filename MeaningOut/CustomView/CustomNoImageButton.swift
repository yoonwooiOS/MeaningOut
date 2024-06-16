//
//  CustomNoImageButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit

class CustomNoImageButton: UIButton {
    
    init(title: String, textColor: UIColor, fontSize: UIFont, backgroundColor bgColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        setTitleColor(textColor, for: .normal)
        
        titleLabel?.font = fontSize
        
        backgroundColor = bgColor
        
        layer.cornerRadius = cornerRadius
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
