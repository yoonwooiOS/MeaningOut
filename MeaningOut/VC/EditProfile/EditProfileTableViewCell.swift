//
//  EditProfileTableViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/18/24.
//

import UIKit
import SnapKit


class EditProfileTableViewCell: UITableViewCell {

    static let identifier = "EditProfileTableViewCell"
    
    let settingLabel = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.regular14)
    
    let totalBookmarkLabel = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .right, fontSize: CustomFont.regular13)
    let bookMarkImage = CustomImageView(imageName: "", color: CustomColor.black)
   
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        setUpHierarchy()
        setUpLayout()
        
    }
    
    private func setUpHierarchy() {
        
        contentView.addSubview(settingLabel)
        contentView.addSubview(totalBookmarkLabel)
        contentView.addSubview(bookMarkImage)
        
    }
    
    private func setUpLayout() {
        
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
     
    func setUpCell(data: String, list: [String]) {
        
        settingLabel.text = data
        
        if data == "나의 장바구니" {
            totalBookmarkLabel.text = "\(list.count)개의 상품"
            bookMarkImage.image = UIImage(named: "like_selected")
        } else {
            
            totalBookmarkLabel.isHidden = true
            bookMarkImage.isHidden = true
            
        }
        
        if data != "탈퇴하기" {
            
            selectionStyle = .none
        }
        
        
    }
   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

