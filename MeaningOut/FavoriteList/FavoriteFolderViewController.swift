//
//  FavoriteFolderViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 7/9/24.
//

import UIKit
import SnapKit
import RealmSwift

class FavoriteFolderViewController: BaseViewController {
    
    let tableView = {
        let tableView = UITableView()
        
        tableView.register(FavoriteFolderTableViewCell.self, forCellReuseIdentifier: FavoriteFolderTableViewCell.identifier)
        return tableView
    }()
    let repository = ProductTableRepository()
    var list: [Folder]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        repository.detectRealmURL()
        
        list = repository.fetchFoler()
    }
    override func setUpHierarchy() {
        view.addSubview(tableView)
    }
    override func setUpLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setUpNavigationItem() {
        navigationItem.title = "좋아요"
    }
}

extension FavoriteFolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = list else { return 0}
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteFolderTableViewCell.identifier, for: indexPath) as! FavoriteFolderTableViewCell
        guard let data = list?[indexPath.row] else { return cell}
        
        cell.setUpcell(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FavoriteViewController()
        if let folder = list?[indexPath.row] {
            vc.folder = folder
                   navigationController?.pushViewController(vc, animated: true)
        }
       
       
    }
    
    
}
