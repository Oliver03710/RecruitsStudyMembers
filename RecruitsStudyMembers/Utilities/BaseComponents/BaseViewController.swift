//
//  BaseViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }
    
    
    // MARK: - Selectors
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI () { }
    func setConstraints() { }
    
    func setNaigations() {
        setNaviBar()
        
        let backButton = UIBarButtonItem(image: UIImage(named: GeneralIcons.arrow.rawValue), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = backButton
    }
}
