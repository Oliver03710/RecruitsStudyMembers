//
//  DeleteAccountViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/23.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

final class DeleteAccountViewController: BaseViewController {

    // MARK: - Properties
    
    private let deleteView = DeleteAccountView()
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = deleteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        bindData()
    }
    
    private func bindData() {
        deleteView.cancelButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        deleteView.confirmButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.deleteAccount()
            }
            .disposed(by: disposeBag)
    }
    
    private func deleteAccount() {
        NetworkManager.shared.request(router: SeSacApiUser.withdraw)
            .subscribe(onSuccess: { response in
                print(response)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = SplashViewController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
                
                UserDefaultsManager.removeAll()
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacUserError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    NetworkManager.shared.fireBaseError {
                        self?.deleteAccount()
                    } errorHandler: {
                        self?.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요.", position: .top)
                    } defaultErrorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.", position: .top)
                    }
                    
                case .unsignedupUser, .ServerError, .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
}
