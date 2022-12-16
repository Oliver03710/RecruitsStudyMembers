//
//  ShopViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import RxCocoa
import RxSwift

final class ShopViewController: BaseViewController {

    // MARK: - Properties
    
    private let shopView = ShopView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = shopView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shopView.checkMyShopState()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        
    }
}
