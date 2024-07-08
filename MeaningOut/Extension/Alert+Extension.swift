//
//  Alert+Extension.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/24/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(t: String, msg: String, style: UIAlertController.Style, ok: String, complitionHandler: @escaping (UIAlertAction) -> Void ) {
        
        let alert = UIAlertController(title: t, message: msg, preferredStyle: style)
        
        let canel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: ok, style: .destructive, handler: complitionHandler)
        
        alert.addAction(ok)
        alert.addAction(canel)
        present(alert, animated: true, completion: nil)
        
        
    }
}
