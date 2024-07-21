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
    func addFolder(_ folder: Folder) {
            do {
                try realm.write {
                    realm.add(folder)
                }
            } catch {
                print("Realm Error: \(error)")
            }
        }
    
    func addToFolder(_ product: ProductTable, folder: Folder) {
            do {
                try realm.write {
                    folder.detail.append(product)
                    print("Realm Create Succeeded")
                }
            } catch {
                print("Realm Error: \(error)")
            }
        }
    
    func fetchFoler() -> [Folder] {
        let folders = realm.objects(Folder.self)
        return Array(folders)
    }
    
    func removeToFolder(_ product: ProductTable, folder: Folder) {
            do {
                try realm.write {
                    if let index = folder.detail.index(of: product) {
                        folder.detail.remove(at: index)
                        print("상품이 폴더에서 삭제되었습니다.")
                    }
                    realm.delete(product)
                }
            } catch {
                print("상품 삭제 중 오류 발생: \(error)")
            }
        }
    func removeFolder(_ folder: Folder) {
            do {
                try realm.write {
                    realm.delete(folder.detail) // 폴더 안의 모든 상품 삭제
                    realm.delete(folder) // 폴더 삭제
                }
            } catch {
                print("Realm Error: \(error)")
            }
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
    
    //MARK: SceneDelegate에서 처음 폴더 생성시 중복된 이름 필터
    func addFolderIfNotExists(_ name: String) {
       
        let existingFolder = realm.objects(Folder.self).filter { folder in
            folder.name == name
        }.first
        
        if existingFolder != nil {
            print("Folder with name '\(name)' already exists.")
            return
        }
        
        let newFolder = Folder()
        newFolder.name = name
        
        do {
            try realm.write {
                realm.add(newFolder, update: .modified)
                print("Added new folder: \(name)")
            }
        } catch {
            print("Realm Error: \(error)")
        }
    }
}
