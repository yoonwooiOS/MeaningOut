//
//  BlackColorLabel.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit


class BlackColorLabel: UILabel {
    
    init(title: String, textAlignmet:  NSTextAlignment, fontSize: UIFont) {
        super.init(frame: .zero)
        
        text = title
        textColor = CustomColor.black
        font = fontSize
        textAlignment = textAlignmet
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


