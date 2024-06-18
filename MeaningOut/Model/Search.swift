//
//  Search.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/17/24.
//

import Foundation

struct Search: Decodable {
    let total: Int
    var items: [Item]
}

struct Item: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
}

