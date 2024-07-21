//
//  ProfileNickNameSettingViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import SnapKit

final class ProfileNickNameSettingViewController: BaseViewController {
    private lazy var profileImageButton = {
        let button = PrimaryColorCircleImageButton(imageName: "", cornerRadius: PrimaryCircleSize.size)
        button.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        return button
    }()
   
    private lazy var nicknameTextField = {
        let textfield = UITextField()
        textfield.blackTextField(placeholderText: "아이디를 입력해주세요!")
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged )
        return textfield
    }()
    
    private lazy var completeButton = {
        let button = PrimaryColorButton(title: "완료")
        button.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let cameraImage = PirmaryColorCircleImageView(imageName: "camera.fill")
    private let seperator = CustomColorSeperator(bgColor: CustomColor.black)
    private let nicknameStateLabel = PrimaryColorLabel(title: "", textAlignmet: .left)
    
    let viewModel = ProfileNicknameSettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationTitle()
        viewDidLoadBindData()
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearBindData()
        viewModel.inputViewWillAppearTrigger.value = ()
        print(viewModel.user.profileImage, #function)
    }
    func viewDidLoadBindData() {
        viewModel.outputValdationNickName.bind { [weak self] value in
            guard let self else { return }
            self.nicknameStateLabel.text = value
        }
        viewModel.ouputValid.bind { [weak self] value in
            guard let self else { return }
            self.nicknameStateLabel.textColor = value ? CustomColor.appPrimaryColor : .red
            self.completeButton.backgroundColor = value ? CustomColor.appPrimaryColor : .systemGray4
            self.completeButton.isEnabled = value
        }
        viewModel.outputRandomImage.bind { [weak self] value in
            print(#function, "!23123213213123213")
            guard let self else { return }
            self.profileImageButton.setImage(UIImage(named: value), for: .normal)
            
        }
        
    }
    func viewWillAppearBindData() {
        print(#function, "닉네임뷰", viewModel.user.profileImage)
        
        viewModel.outputImage.bind { [weak self] value in
            guard let value, let self else { return }
            self.profileImageButton.setImage(UIImage(named: value), for: .normal)
        }
        
    }
   
     override func setUpHierarchy() { 
         [profileImageButton, cameraImage, nicknameTextField, seperator, nicknameStateLabel,completeButton ].forEach {
             self.view.addSubview($0)
         }
    }
    override func setUpLayout() {
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
    
     func setUpNavigationTitle() {
        navigationItem.title = "PROFILE SETTING"
    }
   
    @objc private func profileImageButtonClicked() {
        viewModel.inputSavedButtonClicked.value = ()
        let vc = ProfileImageSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func completeButtonClicked() {
        viewModel.inputSavedButtonClicked.value = ()
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let tabBar = TabBarController()
        sceneDelegate?.window?.rootViewController = tabBar
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

extension ProfileNickNameSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.inputNickName.value = nicknameTextField.text
    }
}
