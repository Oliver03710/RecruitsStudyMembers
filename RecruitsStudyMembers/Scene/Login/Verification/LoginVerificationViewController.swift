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
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations()
    }
    
    func setNaigations() {
        setNaviBar()
        
        let yourBackImage = UIImage(named: GeneralIcons.arrow.rawValue)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
    
}
