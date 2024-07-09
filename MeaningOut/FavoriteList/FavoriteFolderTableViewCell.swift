//
//  FavoriteFolderTableViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/9/24.
//

import UIKit
import SnapKit

class FavoriteFolderTableViewCell: BaseTableViewCell {
    static let identifier = "FavoriteFolderTableViewCell"
    var folderLabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    override func setUpHierarchy() {
        contentView.addSubview(folderLabel)
    }
    override func setUpLayout() {
        folderLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(18)
            make.centerY.equalToSuperview()
        }
    }
    func setUpcell(data: Folder) {
        folderLabel.text = data.name 
    }
}
