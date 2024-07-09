//
//  EditUserNicknameViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit

class EditUserNicknameViewController: UIViewController {
    
    
    private lazy var profileImageButton = PrimaryColorCircleImageButton(imageName: "\(User.selectedProfileImage)", cornerRadius: PrimaryCircleSize.size)
    
   
    
    private let cameraImage = PirmaryColorCircleImageView(imageName: "camera.fill")
    private let nicknameTextField = CustomBlackBottomLineTextField(placeholderText: "닉네임을 입력해주세요 :)")
    private let seperator = CustomColorSeperator(bgColor: CustomColor.black)
    private let nicknameStateLabel = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.regular13)
    
   
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
        
        print(User.selectedProfileImage,"ViewdidLoad")
        bindData()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        
        //        ud.profileImage
        profileImageButton.setImage(UIImage(named: User.selectedProfileImage), for: .normal)
        nicknameTextField.text = ud.nickname
        print(User.selectedProfileImage,"ViewwillApear")
    }
    func bindData() {
        viewModel.outPutValdationText.bind { value in
            self.nicknameStateLabel.text = value
        }
        viewModel.outPutValid.bind { value in
            self.nicknameStateLabel.textColor = value ? CustomColor.appPrimaryColor : .red
            
        }
    }
    private func setUpHierarchy() {
        
        view.addSubview(profileImageButton)
        view.addSubview(cameraImage)
        view.addSubview(nicknameTextField)
        view.addSubview(seperator)
        view.addSubview(nicknameStateLabel)
        
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
        
        
    }
    
    private func setUPNavigation() {
        
        navigationItem.title = "Edit PROFILE"
        
        navigationItem.backBarButtonItem?.tintColor = .black
        
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
        
        let savedEditProfileButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(completeButtonClicked))
        savedEditProfileButton.tintColor = CustomColor.black
        navigationItem.rightBarButtonItem = savedEditProfileButton
    }
    
    @objc private func profileImageButtonClicked() {
        
        let vc = EditUserProfileImageViewController()
        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeButtonClicked() {
        
        viewModel.inputSavedButtonClicked.value = ()
        if viewModel.isFormValid {
            navigationController?.popViewController(animated: true)
        } else {
            showAlertconfirm(t: "아이디 형식에 맞지 않습니다!", msg: "아이디를 다시 입력해주세요!", style: .alert, ok: "확인")
        }
       
    }
    
}

extension EditUserNicknameViewController: UITextFieldDelegate {
    
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
