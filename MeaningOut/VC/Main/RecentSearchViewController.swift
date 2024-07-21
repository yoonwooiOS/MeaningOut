//
//  RecentSearchViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit

final class RecentSearchViewController: BaseViewController {
    
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
    
    private let viewModel = RecentSearchViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUPNavigationtitle()
        bindData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPNavigationtitle()
        bindData()
    
    }
    private func bindData() {
        viewModel.outputList.bind { [weak self] _ in
            guard let self else { return }
            self.viewModel.outputList.bind { [weak self] _ in
                guard let self = self else { return }
                if self.viewModel.outputList.value.isEmpty {
                    self.recentSearchLabel.isHidden = true
                    self.tableView.isHidden = true
                    self.allRemoveButton.isHidden = true
                    self.noRecentImage.isHidden = false
                    self.noRecentLabel.isHidden = false
                } else {
                    self.recentSearchLabel.isHidden = false
                    self.tableView.isHidden = false
                    self.allRemoveButton.isHidden = false
                    self.noRecentImage.isHidden = true
                    self.noRecentLabel.isHidden = true
                }
                self.tableView.reloadData()
            }
        }
        
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
    }
    
    private func setUPNavigationtitle() {
        guard let nickName = viewModel.ouputNavigtaionTitle.value else { return }
        navigationItem.title = "\(nickName)'s MEANING OUT"
    }
}

extension RecentSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputList.value.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        let data = viewModel.outputList.value[indexPath.row]
        
        cell.setUpCell(data: data)
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removeButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SearchResultViewController()
        vc.userSearchText = viewModel.outputList.value[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func removeButtonClicked(sender: UIButton) {
        viewModel.inputRemoveAtItemIndexPath.value = sender.tag
        viewModel.inputRemoveAtButtonClicked.value = ()
    }
    
    @objc func allRemoveButtonClicked() {
        viewModel.inputRemoveallButtonClicked.value = ()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RecentSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = searchTextField.text else { return false }
        viewModel.inputSearchText.value = searchText
        viewModel.inputTextFieldShouldReturnTrigger.value = ()
        let vc = SearchResultViewController()
        vc.userSearchText = viewModel.inputSearchText.value
        navigationController?.pushViewController(vc, animated: true)
        return true
    }
    
}
