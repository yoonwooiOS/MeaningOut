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

final class ProductDetailViewController: BaseViewController {
    
    let webView = WKWebView()

    var likedButtonList: [String]?
    var product: Item?
    
    let repository = ProductTableRepository()
   
   
    var user = User.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        setUpNavigation()
    }
    
     override func setUpHierarchy() {
        view.addSubview(webView)
    }
    
    override func setUpLayout() {
        webView.snp.makeConstraints { make in
            make.edges.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpWebView() {
        guard let siteurl = product?.link else { return }
        
        let url = URL(string: siteurl)
        guard let urlsString = url else { return }
        let request = URLRequest(url: urlsString)
        webView.load(request)
        
    }
    
    private func setUpNavigation() {
        
        navigationItem.title = product?.mallName
        navigationItem.backBarButtonItem?.tintColor = .black
        
        guard let id = product?.productId else { return }
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
        
        guard var likedButtonList = likedButtonList else { return }
        let vc = EditProfileViewController()
        let productId = product.productId
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
       user.likedProductList = likedButtonList
    }
}
