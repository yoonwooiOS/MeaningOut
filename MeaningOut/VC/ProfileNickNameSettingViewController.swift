//
//  ProfileNickNameSettingViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import SnapKit



class ProfileNickNameSettingViewController: UIViewController {
    
    let randomProfiles = [
        "profile_0", "profile_1", "profile_2", "profile_3", "profile_4",
        "profile_5", "profile_6", "profile_7", "profile_8", "profile_9",
        "profile_10", "profile_11"
    ]
    
   lazy var randomProfileImageName = randomProfiles.randomElement() ?? "profile_0"
    lazy var profileImageButton = PrimaryColorCircleImageButton(imageName: "\(randomProfileImageName)")
    let cameraImage = PirmaryColorCircleImageView(imageName: "camera.fill")
    let nicknameTextField = CustomTextField(placeholderText: "닉네임을 입력해주세요 :)")
    let seperator = CustomColorSeperator(bgColor: CustomColor.black)
    let nicknameStateLabel = PrimaryColorLabel(title: "", textAlignmet: .left)
    
    let completeButton = PrimaryColorButton(title: "완료")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpHierarchy()
        setUpLayout()
        setUPNavigation()
        setUpTextField()
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
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
            $0.size.equalTo(CirecleImage.size)
            
        }
        
        cameraImage.snp.makeConstraints {
            
            $0.trailing.equalTo(profileImageButton.snp.trailing)
            $0.bottom.equalTo(profileImageButton.safeAreaLayoutGuide)
            $0.size.equalTo(CirecleImage.size / 3)
            
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
    
    @objc func profileImageButtonClicked() {
        
        let vc = ProfileImageSettingViewController()
        vc.selectedImageName = randomProfileImageName
        navigationController?.pushViewController(vc, animated: true)
    }
  
    
    
    func setUPNavigation() {
        
        navigationItem.title = "PROFILE SETTING"
        
        navigationItem.backBarButtonItem?.tintColor = .black
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
    }
    
    
}

extension ProfileNickNameSettingViewController: UITextFieldDelegate {
    
    private func setUpTextField() {
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged )
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        validateNickname()
        
    }
    func validateNickname() {
        guard let userNickname = nicknameTextField.text else { return }
        let charSet: CharacterSet = {
            var cs = CharacterSet.lowercaseLetters
            cs.insert(charactersIn: "@#$%")
            cs.insert(charactersIn:"0123456789")
            return cs.inverted
            
        }()
        
        if userNickname.count < 2 || userNickname.count > 10 {
            
            nicknameStateLabel.text = NicknameState.isNotAllowedTextRange.rawValue
            
        } else {
            
            nicknameStateLabel.text = NicknameState.isValidate.rawValue
        }
        
        
    }
}
