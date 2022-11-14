//
//  HomeViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

final class HomeViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = HomeView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations()
    }
    
    override func setNaigations() {
        navigationController?.isNavigationBarHidden = true
    }
    
}
