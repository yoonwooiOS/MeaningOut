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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpHierarchy()
        setUpLayout()
        setUpWebView()
        setUpNavigation()
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
        
    }

}
