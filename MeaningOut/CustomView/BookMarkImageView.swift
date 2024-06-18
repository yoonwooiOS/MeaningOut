//
//  BookMarkImageView.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit


class BookMarkImageView: UIButton {
    
    init(imageName: String, color: UIColor, titleText title: String) {
        super.init(frame: .zero)
        
        
        setImage(UIImage(systemName: imageName), for: .normal)
        setTitle(title, for: .normal)
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

