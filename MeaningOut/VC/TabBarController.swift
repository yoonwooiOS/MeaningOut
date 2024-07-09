//
//  TabBarController.swift
//  MeaningOut
//
//  Created by 김윤우 on 6/16/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = CustomColor.appPrimaryColor
        tabBar.unselectedItemTintColor = .gray
        
        let recentSearchVc = RecentSearchViewController()
        
        let nav1 = UINavigationController(rootViewController: recentSearchVc)
        nav1.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
       
        let nav2 = UINavigationController(rootViewController: EditProfileViewController())
        nav2.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        let nav3 = UINavigationController(rootViewController:  FavoriteFolderViewController())
        nav3.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "star"), tag: 1)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
