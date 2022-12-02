//
//  SplashViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/07.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

final class SplashViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let splashView = SplashView()
    private let disposeBag = DisposeBag()
    
    
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
            
            if !UserDefaultsManager.token.isEmpty {
                self?.requestCheckUser()
                
            } else if !UserDefaultsManager.passOnboarding {
                let vc = OnboardingViewController()
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true)
                
            } else if UserDefaultsManager.passOnboarding {
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }
        }
        
    }
    
    func requestCheckUser() {
        NetworkManager.shared.request(UserData.self, router: SeSacApiUser.login)
            .subscribe(onSuccess: { response, _ in
                print(response)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = MainTabBarController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
                UserDefaultsManager.userName = response.nick
                UserDefaultsManager.userImage = response.sesac
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.requestCheckUser()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                case .unsignedUp:
                    UserDefaultsManager.resetSignupData()
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = LoginViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    
                    let firstVC = LoginVerificationViewController()
                    let targetVC = NicknameViewController()
                    let vcs = [firstVC, targetVC]
                    
                    sceneDelegate?.window?.rootViewController = nav
                    sceneDelegate?.window?.makeKeyAndVisible()
                    nav.push(vcs)
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: disposeBag)
    }
}
