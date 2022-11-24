//
//  UIViewController+Extension.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import UIKit

extension UIViewController {
    
    func setNaviBar(naviTitle: String? = nil, naviBarTintColor: UIColor = SSColors.black.color) {
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .systemBackground
        navigationItem.scrollEdgeAppearance = barAppearance
        
        navigationItem.title = naviTitle
        self.navigationController?.navigationBar.tintColor = naviBarTintColor
        
    }
    
}

