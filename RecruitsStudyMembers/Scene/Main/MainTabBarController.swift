//
//  MainTabBarController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTabBars()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
//        object_setClass(self.tabBar, CustomTabBar.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    private func configureTabBars() {
        viewControllers = [
            createNavController(for: HomeViewController(),
                                title: UserDefaultsManager.homeTabName,
                                image: UIImage(named: TapIcons.homeInact.rawValue),
                                imageTapped: UIImage(named: TapIcons.homeAct.rawValue),
                                backgroundColor: SSColors.white.color),
            
            createNavController(for: ShopViewController(),
                                title: UserDefaultsManager.shopTabName,
                                image: UIImage(named: TapIcons.shopInact.rawValue),
                                imageTapped: UIImage(named: TapIcons.shopAct.rawValue),
                                backgroundColor: SSColors.white.color),
        
            createNavController(for: FriendsViewController(),
                                title: UserDefaultsManager.friendsTabName,
                                image: UIImage(named: TapIcons.friendsInact.rawValue),
                                imageTapped: UIImage(named: TapIcons.friendsAct.rawValue),
                                backgroundColor: SSColors.white.color),
            
            createNavController(for: MyinfoViewController(),
                                title: UserDefaultsManager.MyinfoTabName,
                                image: UIImage(named: TapIcons.myInact.rawValue),
                                imageTapped: UIImage(named: TapIcons.myAct.rawValue),
                                backgroundColor: SSColors.white.color)
        ]
        
        tabBar.tintColor = SSColors.green.color
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?, imageTapped: UIImage?, backgroundColor: UIColor?) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        navController.navigationBar.tintColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = imageTapped
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: -5, right: 0)
        
        rootViewController.navigationItem.title = title
        
        return navController
    }
}
