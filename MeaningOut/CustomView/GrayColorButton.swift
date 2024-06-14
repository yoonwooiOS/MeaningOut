//
//  GrayColorButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

class GrayColorButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        setTitleColor(CustomColor.white, for: .normal)
        
        
        titleLabel?.font = CumstomFont.bold16
        
        backgroundColor = CustomColor.gray
        
        layer.cornerRadius = 20
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
