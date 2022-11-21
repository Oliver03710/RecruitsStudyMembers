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
        NetworkManager.shared.request(UserData.self, router: SeSacApi.login)
            .subscribe(onSuccess: { response in
                print(response)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = MainTabBarController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    guard let codeNum = NetworkManager.shared.refreshToken() else {
                        self?.requestCheckUser()
                        print("Success")
                        return
                    }
                    guard let errorCode = AuthErrorCode.Code(rawValue: codeNum) else { return }
                    switch errorCode {
                    case .tooManyRequests:
                        self?.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요.", position: .center)
                    default:
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.")
                    }
                    
                case .unsignedupUser, .ServerError, .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                default: break
                }
            })
            .disposed(by: disposeBag)
    }

    
}

