//
//  ShopViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

final class ShopViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = ShopView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        
    }
    
}