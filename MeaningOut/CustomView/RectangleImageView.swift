//
//  RectangleImageView.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit


class RectangleImageView: UIImageView {
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        
        image = UIImage(named: imageName)
        contentMode = .scaleToFill
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
