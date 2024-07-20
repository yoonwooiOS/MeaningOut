//
//  NetworkManeger.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/23/24.
//

import UIKit
import Alamofire

class NetworkManeger {
    
    static let shared = NetworkManeger()
    private init() {}
     func callRequestNaverSearch(query: String, sortResult: String, page: Int, complitionHandler: @escaping (Search) -> Void) {
        print(#function)
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(page)&sorst=\(sortResult)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverID,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Search.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
            switch response.result {
            case .success(let value):
//                 dump(value)
                complitionHandler(value)
                print("Success")
                
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }
    
    
}
