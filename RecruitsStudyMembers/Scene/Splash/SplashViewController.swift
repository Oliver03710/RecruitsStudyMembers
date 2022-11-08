//
//  SplashViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/07.
//

import UIKit

final class SplashViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let splashView = SplashView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        transitionAfterAnimation()
    }
    
    func transitionAfterAnimation() {
    
        UIView.animate(withDuration: 1.5) { [weak self] () -> Void in
            self?.splashView.layoutIfNeeded()
        } completion: { [weak self] bool in
            if bool {
                sleep(1)
                let vc = OnboardingViewController()
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true)
            }
        }
        
    }

    
}

