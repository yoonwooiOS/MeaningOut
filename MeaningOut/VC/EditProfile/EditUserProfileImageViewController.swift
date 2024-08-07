//
//  EditUserProfileImageViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit
import SnapKit

final class EditUserProfileImageViewController: BaseViewController {
    
    
    let ud = UserDefaultsManager.shared
    lazy var userProfileImage = PrimaryColorCircleImageButton(imageName: "\(user.profileImage)", cornerRadius: PrimaryCircleSize.size) {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: EditUserProfileImageViewController.layout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier)
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    private let cameraImage = PirmaryColorCircleImageView(imageName: "camera.fill")
    
    private let profileImageList = ProfileImages().profileImageName

    var user = User.shared
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUPNavigation()

    }

     override func setUpHierarchy() {
        view.addSubview(userProfileImage)
        view.addSubview(collectionView)
        view.addSubview(cameraImage)
    }
    
    override func setUpLayout() {
        
        userProfileImage.snp.makeConstraints {
            
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(PrimaryCircleSize.size)
            
        }
        
        cameraImage.snp.makeConstraints {
            
            $0.trailing.equalTo(userProfileImage.snp.trailing)
            $0.bottom.equalTo(userProfileImage.safeAreaLayoutGuide)
            $0.size.equalTo(PrimaryCircleSize.size / 3)
            
        }
        
        collectionView.snp.makeConstraints {
            
            $0.top.equalTo(userProfileImage.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(400)
        }
        
    }
    
    private func setUPNavigation() {
        
        navigationItem.title = "PROFILE SETTING"
        
    }
    
    static private func layout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: GrayCircleSize.width / 4, height: GrayCircleSize.width / 4  )
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = GrayCircleSize.cellSpacing
        layout.minimumInteritemSpacing = GrayCircleSize.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: GrayCircleSize.sectionSpacing, left: GrayCircleSize.sectionSpacing, bottom: GrayCircleSize.sectionSpacing, right: GrayCircleSize.sectionSpacing)
        
        return layout
    }
    
}

extension EditUserProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier, for: indexPath) as! ProfileImageSettingCollectionViewCell
        
        let imageData = profileImageList[indexPath.row]
        
        cell.setUpCell(data: imageData, image: "")

        if imageData == user.profileImage {
            cell.profileImageButton.alpha = 1
            cell.profileImageButton.layer.borderWidth = 3
            cell.profileImageButton.layer.borderColor = CustomColor.appPrimaryColor.cgColor
        } else {
            cell.profileImageButton.alpha = 0.5
            cell.profileImageButton.layer.borderWidth = 1
            cell.profileImageButton.layer.borderColor = CustomColor.gray.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        let selectedImage = profileImageList[indexPath.row]
        userProfileImage.setImage(UIImage(named: selectedImage), for: .normal)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageSettingCollectionViewCell else {
            return }
        
        if user.profileImage != selectedImage {
            cell.profileImageButton.alpha = 1
            cell.profileImageButton.layer.borderWidth = 3
            cell.profileImageButton.layer.borderColor = CustomColor.appPrimaryColor.cgColor
        } else {
            cell.profileImageButton.alpha = 0.5
            cell.profileImageButton.layer.borderWidth = 1
            cell.profileImageButton.layer.borderColor = CustomColor.gray.cgColor
        }
        collectionView.reloadData()
        
        user.profileImage = selectedImage
    }
}





