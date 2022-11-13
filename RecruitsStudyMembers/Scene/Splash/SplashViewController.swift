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
    
        UIView.animate(withDuration: 2) { [weak self] () -> Void in
            self?.splashView.layoutIfNeeded()
        } completion: { [weak self] _ in
            sleep(1)
            
            if UserDefaultsManager.passOnboarding {
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            } else if !UserDefaultsManager.passOnboarding {
                let vc = OnboardingViewController()
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true)
            }
        }
        
    }

    
}

