//
//  FavoriteViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/8/24.
//

import UIKit
import SnapKit
import RealmSwift

class FavoriteViewController: BaseViewController {
    
    lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private func layout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: SearchResultCell.width / 2 , height: SearchResultCell.height  )
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = SearchResultCell.cellSpacing
        layout.minimumInteritemSpacing = SearchResultCell.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: SearchResultCell.sectionSpacing, left: SearchResultCell.sectionSpacing, bottom: SearchResultCell.sectionSpacing, right: SearchResultCell.sectionSpacing)
        
        return layout
    }
    var product: [ProductTable] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    let repository = ProductTableRepository()
    let realm = try! Realm()
    
    override func viewWillAppear(_ animated: Bool) {
        product = repository.fetchAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(product)
        setUpCollectionView()
        setUpNavigationITem()
    }
    override func setUpHierarchy() {
        view.addSubview(collectionView)
    }
    override func setUpLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func setUpCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func setUpNavigationITem() {
        
        navigationItem.title = "장바구니"
    }
    @objc func likeImageButtonClicked(sender: UIButton) {
        
        let realm = try! Realm()
        
        let productId = product[sender.tag].id
        // PK에 접근해 삭제
        if let productToDelete = realm.object(ofType: ProductTable.self, forPrimaryKey: productId) {
            do {
                try realm.write {
                    realm.delete(productToDelete)
                }
                product.remove(at: sender.tag)
                // UserDefault,
                UserDefaults.standard.removeObject(forKey: productId)
                if let removeLikedIndex = User.likedProductList.firstIndex(of: productId) {
                    User.likedProductList.remove(at: removeLikedIndex)
                    }
                
                collectionView.reloadData()
            } catch {
                print("\(error)")
            }
        }
    }
}
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        let data = product[indexPath.row]
        cell.likeImageButton.addTarget(self, action: #selector(likeImageButtonClicked), for: .touchUpInside)
        cell.likeImageButton.tag = indexPath.row
        
        cell.setUpcell(data: data)
        return cell
        
    }
    
}
