//
//  BirthViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class BirthViewController: BaseViewController {

    // MARK: - Properties
    
    private let birthView = BirthView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = birthView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
