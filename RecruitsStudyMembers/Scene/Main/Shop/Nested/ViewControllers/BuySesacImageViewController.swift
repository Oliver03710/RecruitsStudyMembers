//
//  BuySesacImageViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/15.
//

import UIKit

final class BuySesacImageViewController: BaseViewController {
    
    // MARK: - Properties
    
    let buyingView = ShopSharedView(state: .face)

    
    // MARK: - Init
    
    override func loadView() {
        view = buyingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    
}
