//
//  OnboardingViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class OnboardingViewController: BaseViewController {

    // MARK: - Properties
    
    private let onboardingView = OnboardingView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
