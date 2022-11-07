//
//  EmailViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class EmailViewController: BaseViewController {

    // MARK: - Properties
    
    private let emailView = EmailView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = emailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
