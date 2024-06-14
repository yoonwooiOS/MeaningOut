//
//  PrimaryColorLabel.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

class PrimaryColorLabel: UILabel {
    
    init(title: String, textAlignmet:  NSTextAlignment) {
        super.init(frame: .zero)
        
        text = title
        textColor = CustomColor.appPrimaryColor
        font = CumstomFont.regular13
        textAlignment = textAlignmet
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

