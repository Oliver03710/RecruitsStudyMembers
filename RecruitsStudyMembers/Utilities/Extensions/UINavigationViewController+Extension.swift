//
//  UINavigationViewController+Extension.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/24.
//

import UIKit

extension UINavigationController {
    
    func push(_ viewControllers: [UIViewController]) {
        setViewControllers(self.viewControllers + viewControllers, animated: true)
    }

    func popViewControllers(_ count: Int) {
        guard viewControllers.count > count else { return }
        popToViewController(viewControllers[viewControllers.count - count - 1], animated: true)
    }
}

