//
//  ProfileNickNameSettingViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import SnapKit



class ProfileNickNameSettingViewController: UIViewController {
    
    
    private lazy var profileImageButton = PrimaryColorCircleImageButton(imageName: "\(User.selectedProfileImage)", cornerRadius: PrimaryCircleSize.size)
    
    private var randomProfileImageName = ProfileImages().profileImageName.randomElement() ?? "profile_0"
    
    private let cameraImage = PirmaryColorCircleImageView(imageName: "camera.fill")
    private let nicknameTextField = CustomBlackBottomLineTextField(placeholderText: "닉네임을 입력해주세요 :)")
    private let seperator = CustomColorSeperator(bgColor: CustomColor.black)
    private let nicknameStateLabel = PrimaryColorLabel(title: "", textAlignmet: .left)
    
    private let completeButton = PrimaryColorButton(title: "완료")
    let ud = UserDefaultsManager()
    
    let viewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpHierarchy()
        setUpLayout()
        setUPNavigation()
        setUpTextField()
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        User.selectedProfileImage = randomProfileImageName
        print(User.selectedProfileImage,"ViewdidLoad")
        
        bindData()
        
    }
    func bindData() {
        viewModel.outPutValdationText.bind { value in
            self.nicknameStateLabel.text = value
        }
        viewModel.outPutValid.bind { value in
            self.nicknameStateLabel.textColor = value ? CustomColor.appPrimaryColor : .red
            self.completeButton.backgroundColor = value ? CustomColor.appPrimaryColor : .systemGray4
            self.completeButton.isEnabled = value
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        profileImageButton.setImage(UIImage(named: User.selectedProfileImage), for: .normal)
        nicknameTextField.text = ud.nickname
        print(User.selectedProfileImage,"ViewwillApear")
    }
    
    private func setUpHierarchy() {
        
        view.addSubview(profileImageButton)
        view.addSubview(cameraImage)
        view.addSubview(nicknameTextField)
        view.addSubview(seperator)
        view.addSubview(nicknameStateLabel)
        view.addSubview(completeButton)

    }
    
    private func setUpLayout() {
        
        profileImageButton.snp.makeConstraints {
            
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(PrimaryCircleSize.size)
            
        }
        
        cameraImage.snp.makeConstraints {
            
            $0.trailing.equalTo(profileImageButton.snp.trailing)
            $0.bottom.equalTo(profileImageButton.safeAreaLayoutGuide)
            $0.size.equalTo(PrimaryCircleSize.size / 3)
            
        }
        
        nicknameTextField.snp.makeConstraints {
            
            $0.top.equalTo(profileImageButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(40)
            
            
        }
        
        seperator.snp.makeConstraints {
            
            $0.top.equalTo(nicknameTextField.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(1)
            
        }
        
        nicknameStateLabel.snp.makeConstraints {
            
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(20)
            
        }
        
        completeButton.snp.makeConstraints {
            
            $0.top.equalTo(nicknameStateLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(40)
            
        }
    }
    
    private func setUPNavigation() {
        
        navigationItem.title = "PROFILE SETTING"
        
        navigationItem.backBarButtonItem?.tintColor = .black
        
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
        
        
    }
    
    @objc private func profileImageButtonClicked() {
        
        let vc = ProfileImageSettingViewController()
        User.selectedProfileImage = randomProfileImageName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func completeButtonClicked() {
        
        User.selectedProfileImage = randomProfileImageName
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let tabBar = TabBarController()
        
        sceneDelegate?.window?.rootViewController = tabBar
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

extension ProfileNickNameSettingViewController: UITextFieldDelegate {
    
    private func setUpTextField() {
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged )
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.inpudId.value = nicknameTextField.text
    }
}
