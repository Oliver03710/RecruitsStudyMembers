//
//  GenderViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class GenderViewController: BaseViewController {

    // MARK: - Properties
    
    private let genderView = GenderView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = genderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
