//
//  LoginViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class LoginViewController: BaseViewController {

    // MARK: - Properties
    
    let loginView = LoginView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
