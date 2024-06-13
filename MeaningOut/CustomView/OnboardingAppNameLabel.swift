//
//  OnboardingAppNameLabel.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

class OnboardingAppNameLabel: UILabel {
    
    init(labelText: String) {
        super.init(frame: .zero)
        
        text = labelText
        font = Onboarding.Font.bold60
        textColor = Onboarding.Color.appPrimaryColor
        textAlignment = .center
        
      
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

