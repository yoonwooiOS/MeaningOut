//
//  SearchCellImageView.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/17/24.
//

import UIKit
import Kingfisher

class SearchCellImageView: UIImageView {
    
    init(imageURL: String) {
        super.init(frame: .zero)
        
        
        let url = URL(string: imageURL)
        kf.setImage(with: url)
        contentMode = .scaleToFill
        layer.cornerRadius = 7
        clipsToBounds = true
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
