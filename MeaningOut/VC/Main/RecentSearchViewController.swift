//
//  RecentSearchViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit

class RecentSearchViewController: BaseViewController {
    
    private lazy var searchTextField = {
        let textField = CustomSearchTextField(placeholderText: "검색어를 입력하세요")
        textField.delegate = self
        return textField
    }()
    private lazy var allRemoveButton = {
        let button = CustomNoImageButton(title: "전체 삭제", textColor: CustomColor.appPrimaryColor, fontSize: CustomFont.regular14, backgroundColor: .clear, cornerRadius: .zero)
        button.addTarget(self, action: #selector(allRemoveButtonClicked), for: .touchUpInside)
        return button
    }()
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        tableView.rowHeight = 40
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    private let seperator = CustomColorSeperator(bgColor: CustomColor.lightGray)
    private let recentSearchLabel = CustomColorLabel(title: "최근 검색", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.bold16)
   
    private let noRecentImage = RectangleImageView(imageName: "empty")
    private let noRecentLabel = CustomColorLabel(title: "최근 검색어가 없어요", textcolor: CustomColor.black, textAlignmet: .center, fontSize: CustomFont.bold16)
    
    private var userRecentSearchList: [String] = [] {
        didSet {
            User.savedRecentSearchList = userRecentSearchList
            
            if User.savedRecentSearchList.count == 0 {
                recentSearchLabel.isHidden = true
                tableView.isHidden = true
                allRemoveButton.isHidden = true
                noRecentImage.isHidden = false
                noRecentLabel.isHidden = false
            } else {
                recentSearchLabel.isHidden = false
                tableView.isHidden = false
                allRemoveButton.isHidden = false
            }
            tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setUPNavigationtitle()
       

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUPNavigationtitle()
        userRecentSearchList = User.savedRecentSearchList
    }
    
     override func setUpHierarchy() {
        
        view.addSubview(searchTextField)
        view.addSubview(seperator)
        view.addSubview(recentSearchLabel)
        view.addSubview(allRemoveButton)
        view.addSubview(noRecentImage)
        view.addSubview(noRecentLabel)
        view.addSubview(tableView)
        
        
    }
    
     override func setUpLayout() {
        searchTextField.snp.makeConstraints {
            
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
        
        seperator.snp.makeConstraints {
            
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view).inset(2)
            $0.height.equalTo(1)
            
        }
        if userRecentSearchList.count == 0 {
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
        } else {
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
                $0.top.equalTo(allRemoveButton.snp.bottom).offset(8)
                $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
    
    private func setUPNavigationtitle() {
        let nickname = User.nickName
        navigationItem.title = "\(nickname)'s MEANING OUT"
    }
}


extension RecentSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userRecentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        
        
        let data = userRecentSearchList[indexPath.row]
        
        cell.setUpCell(data: data)
        
        cell.removeButton.tag = indexPath.row
        
        cell.removeButton.addTarget(self, action: #selector(removeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SearchResultViewController()
        vc.userSearchText = userRecentSearchList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func removeButtonClicked(sender: UIButton) {
        userRecentSearchList.remove(at: sender.tag)
        User.savedRecentSearchList = userRecentSearchList
        tableView.reloadData()
        
    }
    
    @objc func allRemoveButtonClicked() {
        userRecentSearchList.removeAll()
        searchTextField.text = nil
        User.savedRecentSearchList = userRecentSearchList
        tableView.reloadData()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RecentSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let searchText = searchTextField.text else { return false }
       
        userRecentSearchList.append(searchText)
        searchTextField.resignFirstResponder()
        let vc = SearchResultViewController()
        vc.userSearchText = searchText
        navigationController?.pushViewController(vc, animated: true)
     
        return true
    }
    
}
