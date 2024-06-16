//
//  NoRecentSearchViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit
import SnapKit

class NoRecentSearchViewController: UIViewController {
    
    let searchTextField = CustomSearchTextField(placeholderText: "검색어를 입력하세요")
    let seperator = CustomColorSeperator(bgColor: CustomColor.lightGray)
    let noRecentImage = RectangleImageView(imageName: "empty")
    let noRecentLabel = BlackColorLabel(title: "최근 검색어가 없어요", textAlignmet: .center, fontSize: CumstomFont.bold16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpHierarchy()
        setUpLayout()
        setUpUI()
        
    }
    
    private func setUpHierarchy() {
        
        view.addSubview(searchTextField)
        view.addSubview(seperator)
        view.addSubview(noRecentImage)
        view.addSubview(noRecentLabel)
        
        
    }
    
    private func setUpLayout() {
        
        searchTextField.snp.makeConstraints {
            
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
        
        seperator.snp.makeConstraints {
            
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view).inset(2)
            $0.height.equalTo(1)
            
        }
        
        noRecentImage.snp.makeConstraints {
            
            
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(280)
            
        }
        
        noRecentLabel.snp.makeConstraints {
            
            $0.top.equalTo(noRecentImage.snp.bottom).offset(8)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(30)
        }
        
    }
    private func setUpUI() {
        guard let nickname = User.nickName else { return }
        navigationItem.title = "\(nickname)'s MEANING OUT"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
       
    }
    
    @objc func addTapped() {
        
        UserDefaults.standard.removeObject(forKey: "nickname")
        print("nickname 값 삭제")
    }
    
}
