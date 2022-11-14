//
//  MyinfoViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

final class MyinfoViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = MyinfoView()
    
    
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
