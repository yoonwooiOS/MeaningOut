//
//  ProductDetailViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit
import WebKit
import SnapKit

class ProductDetailViewController: UIViewController {
    
    let webView = WKWebView()
    var storeName: String?
    var siteURL:String?
    var productId: String?
    var likedButtonList: [String]? 
    //    let likedImageButton = CustomAssetButton(imageName: "", bgColor: <#T##UIColor#>)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpHierarchy()
        setUpLayout()
        setUpWebView()
        setUpNavigation()
//        print(likedButtonList, "웹뷰")
    }
    
    private func setUpHierarchy() {
        
        view.addSubview(webView)
        
    }
    
    private func setUpLayout() {
        
        webView.snp.makeConstraints { make in
            make.edges.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
    }
    
    private func setUpWebView() {
        
        guard let siteurl = siteURL else { return }
        
        let url = URL(string: siteurl)
        guard let urlsString = url else { return }
        let request = URLRequest(url: urlsString)
        webView.load(request)
        
    }
    
    private func setUpNavigation() {
        
        navigationItem.title = storeName
        navigationItem.backBarButtonItem?.tintColor = .black
        
        guard let id = productId else { return }
        let likeImage = UserDefaults.standard.bool(forKey: id) ? "like_selected" : "like_unselected"
        let rigthBarButtonItem = UIBarButtonItem(image: UIImage(named: likeImage) , style: .plain, target: self, action: #selector(rightBarButtonITemTapped))
        rigthBarButtonItem.tintColor = CustomColor.black
        
        
        navigationItem.rightBarButtonItem = rigthBarButtonItem
        
    }
    @objc func rightBarButtonITemTapped() {
        guard var likedButtonList = likedButtonList, let productId = productId else { return }
        let vc = EditProfileViewController()
        if UserDefaults.standard.bool(forKey: productId) {
            
            UserDefaults.standard.set(false, forKey: productId)
            if let removeLikedImage = likedButtonList.firstIndex(of: productId) {
                likedButtonList.remove(at: removeLikedImage)
                navigationItem.rightBarButtonItem?.image = UIImage(named: "like_unselected")
               
               
                
            }
            
        } else {
            
            UserDefaults.standard.set(true, forKey: productId)
            likedButtonList.append(productId)
            navigationItem.rightBarButtonItem?.image = UIImage(named: "like_selected")
            
        }
        vc.list = likedButtonList
        User.likedProductList = likedButtonList
        print(likedButtonList, "productDdetail")
        
        
    }
}
