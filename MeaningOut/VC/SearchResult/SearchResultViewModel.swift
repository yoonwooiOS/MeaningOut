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
    
    var inputButtonTag: Observable<Int?> = Observable(nil)
    var ouputButtonTag:  Observable<Int?> = Observable(nil)
    var inputfiltetedButtonTag: Observable<Int?> = Observable(nil)
    
    var outputProductList: Observable<Search?> = Observable(nil)
    var outputTotalSeachResultCount: Observable<String?> = Observable("")
    var page = 1
    lazy var ouputPage: Observable<Int?> = Observable(self.page)
    var sortResult: String = "sim"
    
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
            
            let lastPage = totalProuctItem % 30
            for item in value {
                if productList.count - 4 == item.row && lastPage != 0 {
                    self.page += 30
                    self.callRequest(searchText: searchText, page: self.page, srotResult: sortResult)
                }
            }
        }
        
        inputButtonTag.bind { [weak self] value in
            print(#function)
            guard let value, let self, let searchText = self.inputSearchText.value else {
                print("inputButtonTag error")
                return }
            self.page = 1
                switch value {
                case 0:
                    self.sortResult = SearchSorted.sim.rawValue
                    print("Case0")
                case 1:
                    print(SearchSorted.date.rawValue)
                    self.sortResult = SearchSorted.date.rawValue
                    print("Case1")
                case 2:
                    self.sortResult = SearchSorted.asc.rawValue
                    print("Case2")
                case 3:
                    self.sortResult = SearchSorted.dsc.rawValue
                    print("Case3")
                default:
                    self.sortResult = SearchSorted.sim.rawValue
                    print("No Case !!!!!!!!!!!!!!")
                }
            self.ouputButtonTag.value = value
            callRequest(searchText: searchText, page: page, srotResult: sortResult)
        }
    }
    
    private func callRequest(searchText: String, page: Int, srotResult: String) {
        NetworkManeger.shared.callRequestNaverSearch(query: searchText, sortResult:  self.sortResult, page: self.page) { value in
            print(#function, self.sortResult, "dsadasdsa")
            if self.page == 1 {
                self.outputProductList.value = value
            } else {
                self.outputProductList.value?.items.append(contentsOf: value.items)
            }
            self.outputTotalSeachResultCount.value = value.total.formatted()
            self.ouputPage.value = self.page
        }
    }
    
}
