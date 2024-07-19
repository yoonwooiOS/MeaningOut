//
//  SearchResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/17/24.
//

import UIKit
import Kingfisher

final class SearchResultCollectionViewCell: BaseCollectionViewCell {
    
    private var productImage = SearchCellImageView(imageURL: "")
    var likeImageButton = CustomAssetButton(imageName: "like_unselected", bgColor: CustomColor.blackAlpah50)
    private let storeName = CustomColorLabel(title: "", textcolor: CustomColor.lightGray, textAlignmet: .left, fontSize: CustomFont.regular13)
    private let productName = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.regular13)
    private let productPrice = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.bold15)
    

    override func setUpHierarchy() {
        
        contentView.addSubview(storeName)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(productImage)
        contentView.addSubview(likeImageButton)
    }
    
    override func setUpLayout() {
        
        productImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(200)
        }
        
        storeName.snp.makeConstraints {
            $0.top.equalTo(productImage.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(20)
        }
        
        productName.snp.makeConstraints {
            $0.top.equalTo(storeName.snp.bottom)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(40)
        }
        
        productPrice.snp.makeConstraints {
            $0.top.equalTo(productName.snp.bottom)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(28)
        }
        likeImageButton.snp.makeConstraints {
            $0.trailing.equalTo(productImage.snp.trailing).inset(18)
            $0.bottom.equalTo(productImage.snp.bottom).inset(18)
            $0.size.equalTo(40)
        }
    }
    
    func setUpcell(productData: Item ) {
        print(productData)
        let url = URL(string: productData.image)
        let formattedPrice = Int(productData.lprice)?.formatted()
        productImage.kf.setImage(with: url)
        storeName.text = productData.mallName
        
        let title = productData.title
        let replacingTitle = title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        
        productName.text = replacingTitle
        productPrice.text = "\(formattedPrice ?? "")원"
        let likeImgae = UserDefaults.standard.bool(forKey: productData.productId) ? "like_selected" : "like_unselected"
        
        likeImageButton.setImage(UIImage(named: likeImgae), for: .normal)
        likeImageButton.backgroundColor = UserDefaults.standard.bool(forKey: productData.productId) ? CustomColor.white : CustomColor.blackAlpah50
    }
}
