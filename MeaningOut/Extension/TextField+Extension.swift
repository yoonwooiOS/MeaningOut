//
//  TextField+Extension.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addleftimage(image: UIImage, padding: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding * 2, height: image.size.height))
        
        let leftimage = UIImageView(frame: CGRect(x: padding, y: 0, width: image.size.width, height: image.size.height))
        leftimage.image = image
        leftimage.contentMode = .scaleToFill
        leftimage.tintColor = CustomColor.gray
        
        paddingView.addSubview(leftimage)
        
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
