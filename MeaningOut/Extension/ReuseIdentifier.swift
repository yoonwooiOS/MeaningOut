//
//  ReuseIdentifier.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/10/24.
//

import Foundation

extension NSObjectProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
