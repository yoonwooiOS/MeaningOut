//
//  RecentSearchTableViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit
import SnapKit

class RecentSearchTableViewCell: UITableViewCell {

    static let identifier = "RecentSearchTableViewCell"
    
    let clockImage = CustomImageView(imageName: "clock", color: CustomColor.black)
    let recentSearchLabel = CustomColorLabel(title: "1", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.regular16)
    let removeButton = CustomSystemImageButton(imageName: "xmark", tColor: CustomColor.black)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpHierarchy()
        setUpLayout()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        
        contentView.addSubview(clockImage)
        contentView.addSubview(recentSearchLabel)
        contentView.addSubview(removeButton)

    }
    
    private func setUpLayout() {
        
        clockImage.snp.makeConstraints {
            
            $0.leading.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(20)
            
        }
        
        recentSearchLabel.snp.makeConstraints {
            
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(clockImage.snp.trailing).offset(8)
            $0.trailing.equalTo(removeButton.snp.leading).inset(-8)

        }
        
        removeButton.snp.makeConstraints {
            
            
            $0.trailing.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(20)
            
        }
       
    }
    
     func setUpCell(data: String) {
        
         recentSearchLabel.text = data
         
    }

}
