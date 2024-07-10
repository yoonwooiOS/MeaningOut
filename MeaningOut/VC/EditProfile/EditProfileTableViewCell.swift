//
//  EditProfileTableViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit
import SnapKit


final class EditProfileTableViewCell: BaseTableViewCell {

    static let identifier = "EditProfileTableViewCell"
    
    let settingLabel = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.regular14)
    
    var totalBookmarkLabel = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .right, fontSize: CustomFont.regular13)
    let bookMarkImage = CustomImageView(imageName: "", color: CustomColor.black)
    
     override func setUpHierarchy() {
        
        contentView.addSubview(settingLabel)
        contentView.addSubview(totalBookmarkLabel)
        contentView.addSubview(bookMarkImage)
        
    }
    
    override func setUpLayout() {
        
        settingLabel.snp.makeConstraints {
            
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.width.equalTo(120)
            $0.height.equalTo(20)
            
        }
        
        totalBookmarkLabel.snp.makeConstraints {
            
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(20)
        }
        bookMarkImage.snp.makeConstraints {
            
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.trailing.equalTo(totalBookmarkLabel.snp.leading)
            $0.size.equalTo(20)
            
        }
    }
     
    func setUpCell(data: String, list:[String]) {
        settingLabel.text = data
        if settingLabel.text == "나의 장바구니" {
            bookMarkImage.image = UIImage(named: "like_selected")
            totalBookmarkLabel.text = "\(list.count)개의 상품"
            // cell재사용 메커니즘으로 인해 초기 설정을 꼭 해줘야함
            // 해주지 않으면 화면에 그려지지 않음
            totalBookmarkLabel.isHidden = false
            bookMarkImage.isHidden = false
        } else {
            totalBookmarkLabel.isHidden = true
            bookMarkImage.isHidden = true
        }
        if data != "탈퇴하기" {
            selectionStyle = .none
        }
    }
}

