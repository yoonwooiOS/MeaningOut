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
        guard let nickname = nicknameTextField.text else { return }
        User.nickName = nickname
        User.selectedProfileImage = randomProfileImageName
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: currentDate)
        
        User.joinDate = currentDateString
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let tabBar = TabBarController()
//        let navigationController = UINavigationController(rootViewController:tabBar )
        
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
        
        validateNickname()
        
    }
    
    private func validateNickname() {
        guard let userNickname = nicknameTextField.text else { return }
        
        let regexNumber = "[0-9]"
        let isNumberContains = userNickname.range(of: regexNumber, options: .regularExpression) != nil
        
        let regexSpecialCharacters = "[@#$%]"
        let ispecialCharactersContains = userNickname.range(of: regexSpecialCharacters, options: .regularExpression) != nil
        
        if userNickname.count < 2 || userNickname.count > 10 {
            nicknameStateLabel.text = NicknameState.isNotAllowedTextRange.rawValue
        } else {
            nicknameStateLabel.text = NicknameState.isValidate.rawValue
        }
        // MARK: 특수문자 입력 검증
        if ispecialCharactersContains {
            nicknameStateLabel.text = NicknameState.isUsedSpecialCharacters.rawValue
            return
        }
        
        // MARK: 숫자 입력 검증
        if isNumberContains  {
            nicknameStateLabel.text = NicknameState.isUsedNumber.rawValue
            return
        }
        
    }
}
