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
    private let ud = UserDefaultsManager.shared
    private var user = User.shared
    private lazy var userRecentSearchList: [String] = user.savedRecentSearchList
    {
        didSet {
            if userRecentSearchList.isEmpty {
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
            print(userRecentSearchList,"didset")
            tableView.reloadData()
            print("테이블 뷰 리로드 됨")
        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUPNavigationtitle()
        userRecentSearchList = user.savedRecentSearchList
        print(#function, userRecentSearchList)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPNavigationtitle()
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
            
//        view.layoutIfNeeded()
        }
    
    private func setUPNavigationtitle() {
        navigationItem.title = "\(ud.nickname)'s MEANING OUT"
    }
}

extension RecentSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return userRecentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        
        
        let data = userRecentSearchList[indexPath.row]
//        print(data,"------")
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
        user.savedRecentSearchList = userRecentSearchList
        
    }
    
    @objc func allRemoveButtonClicked() {
        userRecentSearchList.removeAll()
        user.savedRecentSearchList = userRecentSearchList
        searchTextField.text = nil
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let searchText = searchTextField.text else { return  }
//        print(#function, "배열에 추가")
//        userRecentSearchList.append(searchText)
//        print(#function, userRecentSearchList)
        view.endEditing(true)
        
    }
}

extension RecentSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let searchText = searchTextField.text else { return false }
        
//        user.savedRecentSearchList.append(searchText)
        userRecentSearchList.append(searchText)
        print(userRecentSearchList)
        searchTextField.resignFirstResponder()
        user.savedRecentSearchList = userRecentSearchList
        let vc = SearchResultViewController()
        vc.userSearchText = searchText
        navigationController?.pushViewController(vc, animated: true)
        
        return true
    }
    
}
