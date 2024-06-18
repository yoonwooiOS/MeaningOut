//
//  CustomAssetButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit

class CustomAssetButton: UIButton {
    
    init(imageName: String, bgColor: UIColor) {
        super.init(frame: .zero)
        
       
        setImage(UIImage(named: imageName), for: .normal)
        backgroundColor = bgColor
        contentMode = .scaleToFill
        layer.cornerRadius = 10
      
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
