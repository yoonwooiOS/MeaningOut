//
//  EditProfileViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit
import SnapKit

final class EditProfileViewController: BaseViewController {
    
    lazy var gestureView = {
     let view = UIView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    lazy var tableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.identifier)
        
        tableview.rowHeight = 40
        return tableview
    }()
    let topSeperator = CustomColorSeperator(bgColor: CustomColor.lightGray)
    let seperator = CustomColorSeperator(bgColor: CustomColor.lightGray)
    lazy var userProfileImageView = PrimaryColorCircleImageButton(imageName: user.profileImage, cornerRadius: UserProfileImageGrayCircleSize.size)
    lazy var userNicknameLabel = CustomColorLabel(title: user.nickName, textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.bold16)
    lazy var userSingUpDateLabel = CustomColorLabel(title: "\(String(describing: user.joinDate)  ) 가입 ", textcolor: CustomColor.gray, textAlignmet: .left, fontSize: CustomFont.regular13)
    let rightChevronLabel = CustomImageView(imageName: "chevron.right", color: CustomColor.lightGray)
    
    let otherSettingList = ["나의 장바구니", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    lazy var list:[String] = user.likedProductList
    let user = User.shared
    override func viewWillAppear(_ animated: Bool) {
        userProfileImageView.setImage(UIImage(named: user.profileImage), for: .normal)
        userNicknameLabel.text = user.nickName
        list = user.likedProductList
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationTitle()
    }
    
     override func setUpHierarchy() {
        view.addSubview(topSeperator)
        view.addSubview(gestureView)
        gestureView.addSubview(userProfileImageView)
        gestureView.addSubview(userNicknameLabel)
        gestureView.addSubview(userSingUpDateLabel)
        gestureView.addSubview(rightChevronLabel)
        view.addSubview(seperator)
        view.addSubview(tableView)
    }
    
    override func setUpLayout() {
        
        topSeperator.snp.makeConstraints {

            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
            
        }
        gestureView.snp.makeConstraints {
            
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(120)
        }
        userProfileImageView.snp.makeConstraints {
            
            $0.centerY.equalTo(gestureView.safeAreaLayoutGuide)
            $0.leading.equalTo(gestureView.safeAreaLayoutGuide).offset(8)
            $0.size.equalTo(100)
        }
        
        userNicknameLabel.snp.makeConstraints {
            
            $0.top.equalTo(gestureView.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(16)
            $0.height.equalTo(30)
            
        }
        
        userSingUpDateLabel.snp.makeConstraints {
            
            $0.top.equalTo(userNicknameLabel.snp.bottom)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(16)
            $0.height.equalTo(20)
            
            
        }
        rightChevronLabel.snp.makeConstraints {
            
            $0.centerY.equalTo(gestureView)
            $0.trailing.equalTo(gestureView.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(20)
            
        }
        
        seperator.snp.makeConstraints {
            
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.top.equalTo(gestureView.snp.bottom)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            
            $0.top.equalTo(seperator.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
    }
    
    private func setUpNavigationTitle() {
        navigationItem.title = "SETTING"
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view", sender)
        navigationController?.pushViewController(EditUserNicknameViewController(), animated: true)
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherSettingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.identifier, for: indexPath) as! EditProfileTableViewCell
        let data = otherSettingList[indexPath.row]
        
        cell.setUpCell(data: data, list: list)
        print("aa")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if otherSettingList[indexPath.row] == "탈퇴하기" {
            showAlert(t: "탈퇴하기", msg: "탈퇴를 하면 데이터가 모두 초기화 홥니다. 탈퇴 하시겠습니까?", style: .alert, ok: "확인") { kim in
                print(kim)
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let navigationController = UINavigationController(rootViewController: OnboardingViewController())
                
                sceneDelegate?.window?.rootViewController = navigationController
                sceneDelegate?.window?.makeKeyAndVisible()
            }
        }
    }
}
