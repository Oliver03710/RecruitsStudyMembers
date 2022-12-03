//
//  FriendsViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

final class FriendsViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = FriendsView()
    
    
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
    
    deinit {
        print("친구화면 Deinit")
    }
}
