//
//  CustomTextField.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import TextFieldEffects

class CustomTextField: UITextField {
    
    
    
    init(placeholderText: String) {
        super.init(frame: .zero)

        font = CumstomFont.bold14
        textColor = CustomColor.black
        textAlignment = .left
        keyboardType = .default
        borderStyle = .none
        placeholder = placeholderText
        tintColor = CustomColor.gray
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
