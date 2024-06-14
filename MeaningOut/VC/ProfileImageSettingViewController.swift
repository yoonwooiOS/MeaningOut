//
//  ProfileImageSettingViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileImageSettingViewController: UIViewController {
    var selectedImageName:String = ""
    lazy var selectedImageButton = PrimaryColorCircleImageButton(imageName: "\(selectedImageName)")
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ProfileImageSettingViewController.layout())
    
    static func layout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (sectionSpacing * 3 ) - (cellSpacing * 4)
        layout.itemSize = CGSize(width: width / 4, height: width / 4 * 1.3 )
        layout.scrollDirection = .vertical
        // 가로 간격
        layout.minimumLineSpacing = cellSpacing
        // 세로 간격
        layout.minimumInteritemSpacing = cellSpacing
        // Inset vs layout
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        
        return layout
    }
    let cameraImage = PirmaryColorCircleImageView(imageName: "camera.fill")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpHierarchy()
        setUpLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier)
    }
    
    private func setUpHierarchy() {
        
        view.addSubview(selectedImageButton)
        view.addSubview(collectionView)
        view.addSubview(cameraImage)
        
        
    }
    
    private func setUpLayout() {
        
        selectedImageButton.snp.makeConstraints {
            
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(CirecleImage.size)
            
        }
        
        cameraImage.snp.makeConstraints {
            
            $0.trailing.equalTo(selectedImageButton.snp.trailing)
            $0.bottom.equalTo(selectedImageButton.safeAreaLayoutGuide)
            $0.size.equalTo(CirecleImage.size / 3)
            
        }
        
        collectionView.snp.makeConstraints {
            
            $0.top.equalTo(selectedImageButton.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(400)
        }
        
    }
    
}

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier, for: indexPath) as! ProfileImageSettingCollectionViewCell
        
        return cell
    }
    
    
    
    
    
    
}
