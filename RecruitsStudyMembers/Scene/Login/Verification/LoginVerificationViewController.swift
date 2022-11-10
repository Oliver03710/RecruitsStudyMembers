//
//  LoginVerificationViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import UIKit

final class LoginVerificationViewController: BaseViewController {

    // MARK: - Properties
    
    private let loginVerificationView = LoginVerificationView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = loginVerificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
