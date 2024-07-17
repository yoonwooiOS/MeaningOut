//
//  SearchResultViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/16/24.
//

import Foundation

//ViewdidLoad - 통신,
class SearchResultViewModel {
    var inputCallRequestTrigger: Observable<Void?> = Observable(nil)
    var inputSearchText: Observable<String?> = Observable("")
    var outputProductList: Observable<Search?> = Observable(nil)
    
    
    private var page = 1
    
    init() {
        
        inputCallRequestTrigger.bind { [weak self] value in
            guard let  self, let searchText = self.inputSearchText.value,  value != nil else { return }
            self.callRequest(query: searchText, sortResult: SearchSorted.sim.rawValue, page: self.page)
            
            
        }
        
    }
    
    
    
    
    func callRequest(query: String, sortResult: String, page: Int) {
        //input - query: userText, sortReuslt : enum, page: page
        NetworkManeger.shared.callRequestNaverSearch(query: query, sortResult: sortResult, page: page) { value in
            print(value,#function)
            self.outputProductList.value = value 
           
           
        }
        
    }
   
    
}
