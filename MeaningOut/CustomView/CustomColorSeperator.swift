//
//  CustomColorSeperator.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

class CustomColorSeperator: UIView {
    
    init(bgColor: UIColor) {
        super.init(frame: .zero)
        
        backgroundColor = bgColor
       
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
