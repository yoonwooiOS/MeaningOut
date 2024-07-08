//
//  Product.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/8/24.
//

import UIKit
import RealmSwift

class ProductTable: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted(indexed: true) var name: String // 상품 제목 필수
    @Persisted var imageURL: String?
    @Persisted var storeName: String?
    @Persisted var price: String?
    
    convenience init(id: String,name: String, imageURL: String?, storeName: String?, price: String?) {
        self.init()
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.storeName = storeName
        self.price = price
    }
    
}
