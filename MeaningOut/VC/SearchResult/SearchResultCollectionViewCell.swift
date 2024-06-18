//
//  SearchResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/17/24.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchResultCollectionViewCell"
    
    
    
    
    var productImage = SearchCellImageView(imageURL: "")
    let likeImageButton = CustomAssetButton(imageName: "like_unselected", bgColor: CustomColor.blackAlpah50)
    let storeName = CustomColorLabel(title: "", textcolor: CustomColor.lightGray, textAlignmet: .left, fontSize: CustomFont.regular13)
    let productName = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.regular13)
    let productPrice = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.bold15)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
        
        
    }
    
    private func setUpHierarchy() {
        
        contentView.addSubview(productImage)
        productImage.addSubview(likeImageButton)
        contentView.addSubview(storeName)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        
    }
    
    private func setUpLayout() {
        
        productImage.snp.makeConstraints {
            
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(200)
            
        }
        
        likeImageButton.snp.makeConstraints {
            
            $0.trailing.equalTo(productImage.snp.trailing).inset(18)
            $0.bottom.equalTo(productImage.snp.bottom).inset(18)
            $0.size.equalTo(40)
            
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
    }
    
    func setUpcell(productData: Item ) {
        let url = URL(string: productData.image)
        let formattedPrice = Int(productData.lprice)?.formatted()
        productImage.kf.setImage(with: url)
        storeName.text = productData.mallName
        
        let title = productData.title
        let replacingTitle = title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        
        productName.text = replacingTitle
        productPrice.text = "\(formattedPrice ?? "")원"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
