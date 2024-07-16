//
//  Observable.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/9/24.
//

import Foundation

class Observable<T> {
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    func bind(closure: @escaping (T) -> Void) {
        closure(value) // 바인드 하는 순간 바로 실행
        self.closure = closure
    }
}
