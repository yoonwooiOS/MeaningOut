//
//  CustomSystemImageButton.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit

class CustomSystemImageButton: UIButton {
    
    init(imageName: String, tColor: UIColor) {
        super.init(frame: .zero)
        
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        
        tintColor = tColor
        
        contentMode = .scaleToFill
        
      
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
