//
//  CustomSearchTextField.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit

class CustomSearchTextField: UITextField {
    
    
    
    init(placeholderText: String) {
        super.init(frame: .zero)
        
        addLeftPadding()
        addleftimage(image: UIImage(systemName: "magnifyingglass")!)
        font = CumstomFont.bold14
        textColor = CustomColor.black
        textAlignment = .left
        keyboardType = .default
        borderStyle = .none
        placeholder = placeholderText
        tintColor = CustomColor.darkGray
        backgroundColor = CustomColor.lightGray
        layer.cornerRadius = 7
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

