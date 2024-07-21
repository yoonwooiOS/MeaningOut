//
//  RecentSearchViewModel.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/15/24.
//

import Foundation

class RecentSearchViewModel {
    let user = User.shared
    
    var inputTextFieldShouldReturnTrigger: Observable<Void?> = Observable(nil)
    var inputSearchText: Observable<String> = Observable("")
    var inputRemoveAtButtonClicked: Observable<Void?> = Observable(nil)
    var inputRemoveAtItemIndexPath: Observable<Int?> = Observable(nil)
    var inputRemoveallButtonClicked: Observable<Void?> = Observable(nil)
    
    var outputList: Observable<[String]> = Observable([""])
    var ouputNavigtaionTitle: Observable<String?> = Observable("")
    
    init() {
        outputList.bind { [weak self] _ in
            guard let self else { return }
            self.outputList.value = self.user.savedRecentSearchList
        }
        inputTextFieldShouldReturnTrigger.bind { [weak self] value in
            // vc 생성되기 전에 vm이 먼저 생성되서 bind 구문이 실행
            // 그 시점에 오류가 나는 경우가 많기 때문에 값을 사용하지 않아도 바인딩
            guard  value != nil, let self else { return }
            self.addSearchItem()
            print("저장")
        }
        inputRemoveAtButtonClicked.bind { [weak self] value in
            guard value != nil, let self else { return }
            self.removeSearchItem()
        }
        inputRemoveallButtonClicked.bind { [weak self] value in
            guard value != nil, let self else { return }
            self.removeAllSearchItems()
        }
        ouputNavigtaionTitle.bind { [weak self] value in
            guard value != nil, let self else { return }
            self.ouputNavigtaionTitle.value = user.nickName
        }
    }
    
    func addSearchItem() {
        var updatedList = outputList.value
        updatedList.append(self.inputSearchText.value)
        outputList.value = updatedList
        user.savedRecentSearchList = updatedList
    }
    
    func removeSearchItem() {
        guard let idx = inputRemoveAtItemIndexPath.value else { return }
        var updatedList = outputList.value
        updatedList.remove(at: idx)
        outputList.value = updatedList
        user.savedRecentSearchList = updatedList
    }
    
    func removeAllSearchItems() {
        outputList.value.removeAll()
        user.savedRecentSearchList.removeAll()
    }
}

