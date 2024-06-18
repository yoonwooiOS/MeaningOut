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
   
    var page = 1
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        callRequestNaverSearch(query: userSearchText, sortResult: SearchSorted.sim.rawValue)
        setUpHierarchy()
        setUpLayout()
        setUpCollectionView()
        setUpNavigation()
        accuracySortButton.addTarget(self, action: #selector(accuracySortButtonclicked), for: .touchUpInside)
        dateSortButton.addTarget(self, action: #selector(dateSortButtonClicked), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(highPriceButtonClicked), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(lowPriceButtonClicked), for: .touchUpInside)
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
        
    }
    
    private func setUpNavigation() {
        
        navigationItem.title = userSearchText
        navigationItem.backBarButtonItem?.tintColor = .black
        let blackBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        blackBackButton.tintColor = .black
        navigationItem.backBarButtonItem = blackBackButton

    }
    
    //
    static private func layout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: SearchResultCell.width / 2 , height: SearchResultCell.height  )
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = SearchResultCell.cellSpacing
        layout.minimumInteritemSpacing = SearchResultCell.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: SearchResultCell.sectionSpacing, left: SearchResultCell.sectionSpacing, bottom: SearchResultCell.sectionSpacing, right: SearchResultCell.sectionSpacing)
        
        return layout
    }
    
    func callRequestNaverSearch(query: String, sortResult: String) {
        print(#function)
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(page)&sort=\(sortResult)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverID,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Search.self) { response in
                
                print("STATUS: \(response.response?.statusCode ?? 0)")
                
            switch response.result {
            case .success(let value):
                print("Success")
                if self.page == 1 {
                    self.productList = value
                } else {
                    self.productList.items.append(contentsOf: value.items)
                }
                
                if self.page == 1 {
                    
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    
                }
                
                self.searchResultLabel.text = "\(self.productList.total.formatted())개의 검색 결과"
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }
    
    @objc func accuracySortButtonclicked() {
        print(#function)
        page = 1
        callRequestNaverSearch(query: userSearchText, sortResult: SearchSorted.sim.rawValue)
        accuracySortButton.grayButton()
        dateSortButton.whiteButton()
        highPriceButton.whiteButton()
        lowPriceButton.whiteButton()
        collectionView.reloadData()
        
    }
    
    @objc func dateSortButtonClicked() {
        
        page = 1
        callRequestNaverSearch(query: userSearchText, sortResult: SearchSorted.date.rawValue)
        accuracySortButton.whiteButton()
        dateSortButton.grayButton()
        highPriceButton.whiteButton()
        lowPriceButton.whiteButton()
        collectionView.reloadData()
    }
    
    @objc func highPriceButtonClicked() {
        
        page = 1
        callRequestNaverSearch(query: userSearchText, sortResult: SearchSorted.dsc.rawValue)
        accuracySortButton.whiteButton()
        dateSortButton.whiteButton()
        highPriceButton.grayButton()
        lowPriceButton.whiteButton()
        collectionView.reloadData()
    }
    
    @objc func lowPriceButtonClicked() {
       
        page = 1
        callRequestNaverSearch(query: userSearchText, sortResult: SearchSorted.asc.rawValue)
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
        cell.likeImageButton.addTarget(self, action: #selector(likeImageButtonClicekd), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = productList.items[indexPath.row]
        let vc = ProductDetailViewController()
        vc.siteURL = data.link
        vc.storeName = data.mallName
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: 즐겨찾기 기능 추가 예정
    @objc func likeImageButtonClicekd() {
        
        
        
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
            
                callRequestNaverSearch(query: userSearchText,sortResult: SearchSorted.date.rawValue)
            }
            
        }
    }
    
    
    
    
    
}
