//
//  RecentSearchViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit

class RecentSearchViewController: UIViewController {
    
    let searchTextField = CustomSearchTextField(placeholderText: "검색어를 입력하세요")
    let seperator = CustomColorSeperator(bgColor: CustomColor.lightGray)
    let recentSearchLabel = BlackColorLabel(title: "최근 검색", textAlignmet: .left, fontSize: CumstomFont.bold16)
    let allRemoveButton = CustomNoImageButton(title: "전체 삭제", textColor: CustomColor.appPrimaryColor, fontSize: CumstomFont.regular14, backgroundColor: .clear, cornerRadius: .zero)
    let tableView = UITableView()
    
    let userRecentSearchList = User.recentSearchList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpHierarchy()
        setUpLayout()
        setUpUI()
        setUpTableView()
    }
    
    private func setUpHierarchy() {
        
        view.addSubview(searchTextField)
        view.addSubview(seperator)
        view.addSubview(recentSearchLabel)
        view.addSubview(allRemoveButton)
        view.addSubview(tableView)
        
        
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
        
        recentSearchLabel.snp.makeConstraints {
            
            $0.top.equalTo(seperator.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(30)
            
        }
        
        allRemoveButton.snp.makeConstraints {
            
            $0.top.equalTo(seperator.snp.bottom).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(30)

            
        }
        
        tableView.snp.makeConstraints {
            
            $0.top.equalTo(allRemoveButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    private func setUpUI() {
        guard let nickname = User.nickName else { return }
        navigationItem.title = "\(nickname)'s MEANING OUT"
       
    }
    
    private func setUpTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        tableView.rowHeight = 30
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
       
    }
    @objc func addTapped() {
        
        UserDefaults.standard.removeObject(forKey: "nickname")
        print("nickname 값 삭제")
    }
    
}


extension RecentSearchViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRecentSearchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        guard let userRecentSearchList = userRecentSearchList else { return cell}
        
        let data = userRecentSearchList[indexPath.row]
        
        cell.setUpCell(data: data)
        
        
        
        return cell
    }
    
    
    
    
    
    
}
