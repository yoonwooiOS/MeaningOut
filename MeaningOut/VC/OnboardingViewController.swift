//
//  OnboardingViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/13/24.
//

import UIKit
import SnapKit


class OnboardingViewController: UIViewController {
    
    private let appNameLabel = OnboardingAppNameLabel(labelText: "MeaningOut")
    private let onBoardingImage = RectangleImageView(imageName: "launch")
    private let startButton = PrimaryColorButton(title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpHierarchy()
        setUpLayout()
        setUpButton()
        setUPNavigation()
       
    }
    

    private func setUpHierarchy() {
        
        view.addSubview(appNameLabel)
        view.addSubview(onBoardingImage)
        view.addSubview(startButton)
        
    }
    
    private func setUpLayout() {
        
        appNameLabel.snp.makeConstraints {
            
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(100)
            
            
        }
        
        onBoardingImage.snp.makeConstraints {
            
            $0.top.equalTo(appNameLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(360)
            
            
        }
        
        startButton.snp.makeConstraints {
            
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
            
        }
        
    }
    
    private func setUpButton() {
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
    }
    
    private func setUPNavigation() {
        
        navigationItem.backBarButtonItem?.tintColor = .black
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
    }
        
    @objc private func startButtonClicked() {
        
            navigationController?.pushViewController(ProfileNickNameSettingViewController(), animated: true)
        
    }
    

}
