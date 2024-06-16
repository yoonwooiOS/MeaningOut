//
//  CustomImageView.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit


class CustomImageView: UIImageView {
    
    init(imageName: String, color: UIColor) {
        super.init(frame: .zero)
        
        
        image = UIImage(systemName: imageName)
        tintColor = color
        contentMode = .scaleToFill
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

