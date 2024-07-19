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
    var searchResultCollectionViewPrefecthTrigger:  Observable<[IndexPath]?> = Observable(nil)
    var inputButtonTage: Observable<Int?> = Observable(nil)
    
    var filteredButtonTrigger: Observable<Int?> = Observable(nil)
    var outputProductList: Observable<Search?> = Observable(nil)
    
    
    private var page = 1
    
    init() {
        transfrom()
    }
    
    private func transfrom() {
        inputCallRequestTrigger.bind { [weak self] value in
            guard let  self, let searchText = self.inputSearchText.value, value != nil else { return }
            self.callRequest(searchText: searchText, page: page, srotResult: SearchSorted.sim.rawValue)
        }
        
        searchResultCollectionViewPrefecthTrigger.bind { [weak self] value  in
            
            guard let value, let self ,let searchText = self.inputSearchText.value,
            let totalProuctItem = self.outputProductList.value?.total,
            let productList = self.outputProductList.value?.items else { return }
            print("페이지네이션2")
            let lastPage = totalProuctItem % 30
            for item in value {
                if productList.count - 4 == item.row && lastPage != 0 {
                    self.page += 30
                    print(self.page)
                    self.callRequest(searchText: searchText, page: self.page, srotResult: SearchSorted.asc.rawValue)
                }
            }
        }
        
        filteredButtonTrigger.bind { [weak self] value in
            guard let value, let self else { return }
            
            
        }
    }

    private func callRequest(searchText: String, page: Int, srotResult: String) {
        NetworkManeger.shared.callRequestNaverSearch(query: searchText, sortResult:  srotResult, page: self.page) { value in
            if self.page == 1 {
                self.outputProductList.value = value
                print(#function,"1231232131231231231")
            } else {
               
                self.outputProductList.value?.items.append(contentsOf: value.items)
            }
           
        }
    }
    
}
