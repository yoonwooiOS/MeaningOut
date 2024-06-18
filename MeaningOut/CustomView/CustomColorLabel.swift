//
//  CustomColorLabel.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit


class CustomColorLabel: UILabel {
    
    init(title: String, textcolor: UIColor, textAlignmet:  NSTextAlignment, fontSize: UIFont) {
        super.init(frame: .zero)
        
        text = title
        textColor = textcolor
        font = fontSize
        textAlignment = textAlignmet
        numberOfLines = 2
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


