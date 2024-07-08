//
//  ProductDetailViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit
import WebKit
import SnapKit
import RealmSwift

class ProductDetailViewController: UIViewController {
    
    let webView = WKWebView()
    var storeName: String?
    var siteURL:String?
    var productId: String?
    var likedButtonList: [String]? 
    let repository = ProductTableRepository()
   
    var product: Item?
    
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
        
       
        let realm = try! Realm()
//        print(realm.configuration.fileURL)
        guard let product = product else { return }
        let result = realm.objects(ProductTable.self).where {
            $0.id == product.productId
        }
        print(result)
        if result.isEmpty {
            let data = ProductTable(id: product.productId, name: product.title, imageURL: product.image, storeName: product.link, price: product.lprice)
            repository.createItem(data)
        } else {
    
            repository.deleteItem(result.first!)
        }
        
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
