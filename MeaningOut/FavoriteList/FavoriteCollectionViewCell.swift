//
//  FavoriteCollectionViewCell.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/8/24.
//

import UIKit
import RealmSwift

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    var productImage = SearchCellImageView(imageURL: "")
    let storeName = CustomColorLabel(title: "", textcolor: CustomColor.lightGray, textAlignmet: .left, fontSize: CustomFont.regular13)
    let productName = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.regular13)
    let productPrice = CustomColorLabel(title: "", textcolor: CustomColor.black, textAlignmet: .left, fontSize: CustomFont.bold15)
    lazy var likeImageButton = {
        let button = CustomAssetButton(imageName: "like_unselected", bgColor: CustomColor.blackAlpah50)
       
        return button
        
    }()
    
    let repository = ProductTableRepository()
    
    var product: ProductTable?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
        
    }
    
    private func setUpHierarchy() {
        contentView.addSubview(storeName)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(productImage)
        contentView.addSubview(likeImageButton)
    }
    
    private func setUpLayout() {
        
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
    
    
    func setUpcell(data: ProductTable ) {
        self.product = data
        let url = URL(string: data.imageURL ?? "")
        let formattedPrice = Int(data.price ?? "")?.formatted()
        productImage.kf.setImage(with: url)
        storeName.text = data.storeName
        
        let title = data.name
        let replacingTitle = title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        
        productName.text = replacingTitle
        productPrice.text = "\(formattedPrice ?? "")원"
        
      
        likeImageButton.backgroundColor = CustomColor.white
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






