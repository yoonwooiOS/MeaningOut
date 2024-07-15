//
//  ProfileImageSettingViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/14/24.
//

import UIKit
import SnapKit

final class ProfileImageSettingViewController: BaseViewController {

    private lazy var userProfileImage = PrimaryColorCircleImageButton(imageName: "", cornerRadius: PrimaryCircleSize.size)
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ProfileImageSettingViewController.layout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier)
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
        
    private let cameraImage = PirmaryColorCircleImageView(imageName: "camera.fill")
    private let profileImageList = ProfileImages().profileImageName
    
//    var user = User.shared
    let viewModel = ProfileImageSettingViewModel()
//    lazy var profileImage = user.profileImage
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        user.profileImage = profileImage
        viewWillDisAppearBindData()
        viewModel.viewWillDisappearTrigger.value = ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadBindData()
        print(self.viewModel.user.profileImage)
    }
    func viewDidLoadBindData() {
        
        viewModel.profieImage.bind { value in
            guard let value = value else { return }
            self.userProfileImage.setImage(UIImage(named: value), for: .normal)
        }
        viewModel.inputViewDidloadTrigger.value = ()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function, viewModel.user.profileImage)
    }
    func viewWillDisAppearBindData() {
        viewModel.viewWillDisappearTrigger.value = ()
        print(#function)
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

    override func setUpNavigationItems() {
        navigationItem.title = "PROFILE SETTING"
        
    }
    
    static private func layout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: GrayCircleSize.width / 4, height: GrayCircleSize.width / 4  )
        layout.scrollDirection = .vertical
        // 가로 간격
        layout.minimumLineSpacing = GrayCircleSize.cellSpacing
        // 세로 간격
        layout.minimumInteritemSpacing = GrayCircleSize.cellSpacing
        
        layout.sectionInset = UIEdgeInsets(top: GrayCircleSize.sectionSpacing, left: GrayCircleSize.sectionSpacing, bottom: GrayCircleSize.sectionSpacing, right: GrayCircleSize.sectionSpacing)
        
        return layout
    }
    
}

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputProfileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier, for: indexPath) as! ProfileImageSettingCollectionViewCell
        
        let imageData = viewModel.outputProfileImageList[indexPath.row]
        
        cell.setUpCell(data: imageData, image: viewModel.profieImage.value!)

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
        let selectedImage = viewModel.outputProfileImageList[indexPath.row]
        viewModel.profieImage.value = viewModel.outputProfileImageList[indexPath.row]
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageSettingCollectionViewCell else {
            return }
        
        userProfileImage.setImage(UIImage(named: viewModel.profieImage.value!), for: .normal)
        if viewModel.profieImage.value! == selectedImage {
            cell.profileImageButton.alpha = 1
            cell.profileImageButton.layer.borderWidth = 3
            cell.profileImageButton.layer.borderColor = CustomColor.appPrimaryColor.cgColor
        } else {
            cell.profileImageButton.alpha = 0.5
            cell.profileImageButton.layer.borderWidth = 1
            cell.profileImageButton.layer.borderColor = CustomColor.gray.cgColor
        }
        viewModel.inputSelectedImage.value = selectedImage
        print(#function, selectedImage)
        collectionView.reloadData()
    }
}





