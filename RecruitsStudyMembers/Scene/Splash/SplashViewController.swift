//
//  SplashViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/07.
//

import UIKit

final class SplashViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let splashView = SplashView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

