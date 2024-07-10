//
//  OnboardingViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/13/24.
//

import UIKit
import SnapKit


final class OnboardingViewController: BaseViewController {
    
    private let appNameLabel = OnboardingAppNameLabel(labelText: "MeaningOut")
    private let onBoardingImage = RectangleImageView(imageName: "launch")
    private lazy var startButton = {
        let button = PrimaryColorButton(title: "시작하기")
        button.addTarget(self, action:#selector(startButtonClicked) , for: .touchUpInside)
        return button
    }()
     override func setUpHierarchy() {
        view.addSubview(appNameLabel)
        view.addSubview(onBoardingImage)
        view.addSubview(startButton)
    }
    
     override func setUpLayout() {
         appNameLabel.snp.makeConstraints {
             $0.top.equalTo(view.safeAreaLayoutGuide)
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
    @objc private func startButtonClicked() {
            navigationController?.pushViewController(ProfileNickNameSettingViewController(), animated: true)
    }
}
