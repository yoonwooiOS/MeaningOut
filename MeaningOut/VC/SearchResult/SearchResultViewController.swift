//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/17/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchResultViewController: UIViewController {
    
    var productList = Search(total: 0, items: []) {
        didSet {
            collectionView.reloadData()
        }
    }
    var userSearchText:String = ""
    let searchResultLabel = PrimaryColorLabel(title: "", textAlignmet: .left)
    let accuracySortButton = GrayColorButton(title: "정확도", backgroundColor: CustomColor.gray, tintcolor: CustomColor.white)
    var dateSortButton = GrayColorButton(title: "날짜순", backgroundColor: CustomColor.white, tintcolor: CustomColor.black)
    let highPriceButton = GrayColorButton(title: "가격높은순", backgroundColor: CustomColor.white, tintcolor: CustomColor.black)
    let lowPriceButton = GrayColorButton(title: "가격낮은순", backgroundColor: CustomColor.white, tintcolor: CustomColor.black)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultViewController.layout())
    
    var likedButtonList:[String] = User.likedProductList
    //
    var page = 1
    
    override func viewWillAppear(_ animated: Bool) {
        print(likedButtonList, "viewWillAppaer")
        
        likedButtonList = User.likedProductList
        collectionView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        print(likedButtonList, "viewdidAppaer")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(likedButtonList, "viewdidLoad")
        view.backgroundColor = .systemBackground
        // MARK: API호출
        NetworkManeger.callRequestNaverSearch(query: userSearchText, sortResult:  SearchSorted.sim.rawValue, page: page) { value in
            self.productList = value
            self.searchResultLabel.text = "\(self.productList.total.formatted())개의 검색 결과"
        }
        setUpHierarchy()
        setUpLayout()
        setUpCollectionView()
        setUpNavigation()
        setUpButton()
    }
    private func setUpHierarchy() {
        
        view.addSubview(searchResultLabel)
        view.addSubview(accuracySortButton)
        view.addSubview(dateSortButton)
        view.addSubview(highPriceButton)
        view.addSubview(lowPriceButton)
        view.addSubview(collectionView)
        
    }
    
    private func setUpLayout() {
        
        searchResultLabel.snp.makeConstraints {
            
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.height.equalTo(40)
            
        }
        
        accuracySortButton.snp.makeConstraints {
            
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.height.equalTo(32)
            $0.width.equalTo(60)
        }
        
        dateSortButton.snp.makeConstraints {
            
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(8)
            $0.leading.equalTo(accuracySortButton.snp.trailing).offset(8)
            $0.height.equalTo(32)
            $0.width.equalTo(60)
        }
        
        highPriceButton.snp.makeConstraints {
            
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(8)
            $0.leading.equalTo(dateSortButton.snp.trailing).offset(8)
            $0.height.equalTo(32)
            $0.width.equalTo(92)
        }
        
        lowPriceButton.snp.makeConstraints {
            
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(8)
            $0.leading.equalTo(highPriceButton.snp.trailing).offset(8)
            $0.height.equalTo(32)
            $0.width.equalTo(92)
        }
        
        collectionView.snp.makeConstraints {
            
            $0.top.equalTo(lowPriceButton.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        
    }
    
    private func setUpCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.isUserInteractionEnabled = true
    }
    
    private func setUpNavigation() {
        
        navigationItem.title = userSearchText
        navigationItem.backBarButtonItem?.tintColor = .black
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton
        
    }
    
    private func setUpButton() {
        accuracySortButton.addTarget(self, action: #selector(accuracySortButtonclicked), for: .touchUpInside)
        dateSortButton.addTarget(self, action: #selector(dateSortButtonClicked), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(highPriceButtonClicked), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(lowPriceButtonClicked), for: .touchUpInside)
        
    }
    static private func layout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: SearchResultCell.width / 2 , height: SearchResultCell.height  )
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = SearchResultCell.cellSpacing
        layout.minimumInteritemSpacing = SearchResultCell.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: SearchResultCell.sectionSpacing, left: SearchResultCell.sectionSpacing, bottom: SearchResultCell.sectionSpacing, right: SearchResultCell.sectionSpacing)
        
        return layout
    }
    
    
    
    @objc func accuracySortButtonclicked() {
        print(#function)
        page = 1
        
        callRequest(sortResult: SearchSorted.sim.rawValue)
        
        accuracySortButton.grayButton()
        dateSortButton.whiteButton()
        highPriceButton.whiteButton()
        lowPriceButton.whiteButton()
        collectionView.reloadData()
        
    }
    
    @objc func dateSortButtonClicked() {
        
        page = 1
        callRequest(sortResult: SearchSorted.date.rawValue)
        
        accuracySortButton.whiteButton()
        dateSortButton.grayButton()
        highPriceButton.whiteButton()
        lowPriceButton.whiteButton()
        collectionView.reloadData()
    }
    
    func callRequest(sortResult: String) {
        
        NetworkManeger.callRequestNaverSearch(query: userSearchText, sortResult: sortResult, page: page) { value in
            if self.page == 1 {
                self.productList = value
            } else {
                self.productList.items.append(contentsOf: value.items)
            }
            
            if self.page == 1 {
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            
            self.searchResultLabel.text = "\(self.productList.total.formatted())개의 검색 결과"
        }
    }
    
    @objc func highPriceButtonClicked() {
        
        page = 1
        callRequest(sortResult: SearchSorted.asc.rawValue)
        accuracySortButton.whiteButton()
        dateSortButton.whiteButton()
        highPriceButton.grayButton()
        lowPriceButton.whiteButton()
        collectionView.reloadData()
    }
    
    @objc func lowPriceButtonClicked() {
        
        page = 1
        callRequest(sortResult: SearchSorted.dsc.rawValue)
        accuracySortButton.whiteButton()
        dateSortButton.whiteButton()
        highPriceButton.whiteButton()
        lowPriceButton.grayButton()
        collectionView.reloadData()
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        let data = productList.items[indexPath.row]
        
        cell.setUpcell(productData: data)
        cell.likeImageButton.tag = indexPath.row
        cell.likeImageButton.addTarget(self, action: #selector(likeImageButtonClicekd(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = productList.items[indexPath.row]
        let vc = ProductDetailViewController()
        vc.siteURL = data.link
        vc.storeName = data.mallName
        vc.productId = data.productId
        vc.likedButtonList = likedButtonList
        print(likedButtonList, "cell")
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    //MARK: 즐겨찾기 기능 추가 예정
    @objc func likeImageButtonClicekd(sender: UIButton) {
        //        print(productList.items[sender.tag].productId)
        //        print(sender.tag)
        //        print("sdfsadfds")
        
        if UserDefaults.standard.bool(forKey: "\(productList.items[sender.tag].productId)") {
            UserDefaults.standard.set(false, forKey: "\(productList.items[sender.tag].productId)")
            if let removeLikedImage = likedButtonList.firstIndex(of:  "\(productList.items[sender.tag].productId)") {
                likedButtonList.remove(at: removeLikedImage)
                
                
            }
        } else {
            UserDefaults.standard.set(true, forKey: "\(productList.items[sender.tag].productId)")
            likedButtonList.append(productList.items[sender.tag].productId)
            
        }
        User.likedProductList = likedButtonList
        print(likedButtonList, "버트 클릭")
        collectionView.reloadData()
    }
    
}

//MARK: pagenation
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        let lastPage = productList.total % 30
        for item in indexPaths {
            print(indexPaths, "Prefetch")
            if productList.items.count - 2 == item.row && lastPage != 0 {
                page += 30
                
                callRequest(sortResult: SearchSorted.date.rawValue)

            }
        }
    }
}


