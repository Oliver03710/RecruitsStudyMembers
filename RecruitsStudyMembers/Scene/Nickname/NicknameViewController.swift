//
//  NicknameViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class NicknameViewController: BaseViewController {

    // MARK: - Properties
    
    let nicknameView = NicknameView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
