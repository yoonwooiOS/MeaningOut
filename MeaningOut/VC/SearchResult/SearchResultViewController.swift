//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/17/24.
//

import UIKit
import SnapKit
import Alamofire
import RealmSwift

final class SearchResultViewController: BaseViewController {
    var userSearchText:String = ""
    private let searchResultLabel = PrimaryColorLabel(title: "", textAlignmet: .left)
    private lazy var accuracySortButton = {
        let button = GrayColorButton(title: "정확도", backgroundColor: CustomColor.gray, tintcolor: CustomColor.white)
        button.tag = filterdButton.accuracy.rawValue
        button.addTarget(self, action: #selector(accuracySortButtonclicked), for: .touchUpInside)
        return button
    }()
    private lazy var dateSortButton = {
        let button = GrayColorButton(title: "날짜순", backgroundColor: CustomColor.white, tintcolor: CustomColor.black)
        button.tag = filterdButton.date.rawValue
        button.addTarget(self, action: #selector(dateSortButtonClicked), for: .touchUpInside)
        
        return button
    }()
    private lazy var highPriceButton = {
        let button = GrayColorButton(title: "가격높은순", backgroundColor: CustomColor.white, tintcolor: CustomColor.black)
        button.tag = filterdButton.dsc.rawValue
        button.addTarget(self, action: #selector(highPriceButtonClicked), for: .touchUpInside)
        return button
    }()
    private lazy var lowPriceButton = {
        let button = GrayColorButton(title: "가격낮은순", backgroundColor: CustomColor.white, tintcolor: CustomColor.black)
        button.tag = filterdButton.asc.rawValue
        button.addTarget(self, action: #selector(lowPriceButtonClicked), for: .touchUpInside)
        return button
    }()
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultViewController.layout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    private var user = User.shared
    private lazy var likedButtonList:[String] = user.likedProductList
    private let repository = ProductTableRepository()
    private let viewModel = SearchResultViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        likedButtonList = user.likedProductList
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: API호출
        bindData()
        setUpNavigationTitle()
    }
    private func bindData() {
        viewModel.inputSearchText.value = userSearchText
        viewModel.inputCallRequestTrigger.value = ()
        viewModel.outputProductList.bind { [weak self] value in
            guard let self else { return }
            self.collectionView.reloadData()
        }
        viewModel.outputTotalSeachResultCount.bind { [weak self] value in
            guard let self, let value else { return }
            self.searchResultLabel.text = value + "개의 검색결과"
            self.collectionView.reloadData()
        }
        viewModel.ouputButtonTag.bind { [weak self] value in
            guard let self, value != nil else { return }
            print(#function, "ouputButtonTag")
            self.collectionView.reloadData()
        }
    }
    
    override func setUpHierarchy() {
        
        view.addSubview(searchResultLabel)
        view.addSubview(accuracySortButton)
        view.addSubview(dateSortButton)
        view.addSubview(highPriceButton)
        view.addSubview(lowPriceButton)
        view.addSubview(collectionView)
        
    }
    
    override func setUpLayout() {
        
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
    
    private func setUpNavigationTitle() {
        navigationItem.title = userSearchText
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
        viewModel.inputButtonTag.value = accuracySortButton.tag
        self.accuracySortButton.grayButton()
        self.dateSortButton.whiteButton()
        self.highPriceButton.whiteButton()
        self.lowPriceButton.whiteButton()
        viewModel.ouputPage.bind { value in
            if value == 1 {
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    @objc func dateSortButtonClicked() {
        viewModel.inputButtonTag.value = dateSortButton.tag
        self.accuracySortButton.whiteButton()
        self.dateSortButton.grayButton()
        self.highPriceButton.whiteButton()
        self.lowPriceButton.whiteButton()
        viewModel.ouputPage.bind { value in
            if value == 1 {
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    @objc func highPriceButtonClicked() {
        viewModel.inputButtonTag.value = highPriceButton.tag
        accuracySortButton.whiteButton()
        dateSortButton.whiteButton()
        highPriceButton.grayButton()
        lowPriceButton.whiteButton()
        viewModel.ouputPage.bind { value in
            if value == 1 {
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    @objc func lowPriceButtonClicked() {
        viewModel.inputButtonTag.value = lowPriceButton.tag
        accuracySortButton.whiteButton()
        dateSortButton.whiteButton()
        highPriceButton.whiteButton()
        lowPriceButton.grayButton()
        viewModel.ouputPage.bind { value in
            if value == 1 {
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let productList = viewModel.outputProductList.value else { return 0}
        return productList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        guard let data = viewModel.outputProductList.value?.items[indexPath.row] else { return cell}
        cell.setUpcell(productData: data)
        cell.likeImageButton.tag = indexPath.row
        cell.likeImageButton.addTarget(self, action: #selector(likeImageButtonClicekd(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = viewModel.outputProductList.value?.items[indexPath.row] else { return }
        let vc = ProductDetailViewController()
        vc.product = data
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: 즐겨찾기 기능 VM으로
    @objc func likeImageButtonClicekd(sender: UIButton) {
        //        let product = productList.items[sender.tag]
        //        let realm = try! Realm()
        //        guard let folder = realm.objects(Folder.self).where({ $0.name == "전체" }).first else {
        //            print("폴더를 찾을 수 없습니다.")
        //            return
        //        }
        //        let result = realm.objects(ProductTable.self).where({ $0.id == product.productId })
        //
        //        if result.isEmpty {
        //            let data = ProductTable(id: product.productId, name: product.title, imageURL: product.image, storeName: product.link, price: product.lprice)
        //            repository.addToFolder(data, folder: folder)
        //        } else {
        //            repository.removeToFolder(result.first!, folder: folder)
        //        }
        //
        //        if UserDefaults.standard.bool(forKey: "\(productList.items[sender.tag].productId)") {
        //            UserDefaults.standard.set(false, forKey: "\(productList.items[sender.tag].productId)")
        //            if let removeLikedImage = likedButtonList.firstIndex(of:  "\(productList.items[sender.tag].productId)") {
        //                likedButtonList.remove(at: removeLikedImage)
        //            }
        //        } else {
        //            UserDefaults.standard.set(true, forKey: "\(productList.items[sender.tag].productId)")
        //            likedButtonList.append(productList.items[sender.tag].productId)
        //
        //        }
        //        user.likedProductList = likedButtonList
        //        print(likedButtonList, "버트 클릭")
        //        collectionView.reloadData()
    }
    
}

//MARK: pagenation
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel.searchResultCollectionViewPrefecthTrigger.value = indexPaths
    }
}


