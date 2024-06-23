//
//  EditProfileViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit
import SnapKit

class EditProfileViewController: UIViewController {
    
    let gestureView = UIView()
    let topSeperator = CustomColorSeperator(bgColor: CustomColor.lightGray)
    let seperator = CustomColorSeperator(bgColor: CustomColor.lightGray)
    let tableView = UITableView()
    let userProfileImageView = PrimaryColorCircleImageButton(imageName: User.selectedProfileImage, cornerRadius: UserProfileImageGrayCircleSize.size)
    let userNicknameLabel = CustomColorLabel(title: User.nickName, textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.bold16)
    let userSingUpDateLabel = CustomColorLabel(title: "\(User.joinDate) 가입 ", textcolor: CustomColor.gray, textAlignmet: .left, fontSize: CustomFont.regular13)
    let rightChevronLabel = CustomImageView(imageName: "chevron.right", color: CustomColor.lightGray)
    
    let otherSettingList = ["나의 장바구니", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    var list:[String] = User.likedProductList
    
    override func viewWillAppear(_ animated: Bool) {
        userProfileImageView.setImage(UIImage(named: User.selectedProfileImage), for: .normal)
        userNicknameLabel.text = User.nickName
        
        
        list = User.likedProductList
        tableView.reloadData()
        print(list ?? "", "editprofileList")
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .systemBackground
        setUpHierarchy()
        setUpLayout()
        setUpTableView()
        setUpNavigation()
        setUpGesture()
    }
    

    private func setUpHierarchy() {
        
        view.addSubview(topSeperator)
        view.addSubview(gestureView)
        gestureView.addSubview(userProfileImageView)
        gestureView.addSubview(userNicknameLabel)
        gestureView.addSubview(userSingUpDateLabel)
        gestureView.addSubview(rightChevronLabel)
        
        view.addSubview(seperator)
        view.addSubview(tableView)
        
    }
    
    private func setUpLayout() {
        
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
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.identifier)
        tableView.rowHeight = 40
    }
    private func setUpNavigation() {
        
        navigationItem.title = "SETTING"
        navigationItem.backBarButtonItem?.tintColor = .black
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
    }
    
    private func setUpGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        gestureView.addGestureRecognizer(tapGestureRecognizer)
        
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
            
            showAlert(t: "탈퇴하기", msg: "탈퇴를 하면 데이터가 모두 초기화 됩니다. 탈퇴 하시겠습니까?", style: .alert)
        }
    }
}

extension UIViewController {
    
    func showAlert(t: String, msg: String, style: UIAlertController.Style) {
        
        let alert = UIAlertController(title: t, message: msg, preferredStyle: style)
        
        let ok = UIAlertAction(title: "확인", style: .default) { ok in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let navigationController = UINavigationController(rootViewController: OnboardingViewController())
            
            sceneDelegate?.window?.rootViewController = navigationController
            sceneDelegate?.window?.makeKeyAndVisible()

        }
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
