//
//  ProductTableRepository.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/8/24.
//

import Foundation
import RealmSwift

class ProductTableRepository {
    
    private let realm = try! Realm()
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func createItem(_ data: ProductTable) {
        
        do {
            try realm.write {
                realm.add(data)
                print("생성")
            }
        } catch {
            print("Realm 에러")
        }
        
    }
    
    func fetchAll() ->  [ProductTable] {
       let value = realm.objects(ProductTable.self)
        return Array(value)
    }
    
    func upDate(_ data: ProductTable) {
        do {
            try realm.write {
                realm.add(data, update: .modified)
                print("Realm Update Succeeded")
            }
        } catch {
            print("Realm Error: \(error)")
        }
    }
    
    func deleteItem(_ data: ProductTable) {
        do {
            try realm.write {
                realm.delete(data)
            }
            
        } catch {
            print("Realm Error")
        }
        
    }
}
