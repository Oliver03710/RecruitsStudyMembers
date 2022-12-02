//
//  CustomAlertViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/23.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift
import Toast

final class CustomAlertViewController: BaseViewController {

    // MARK: - Properties
    
    let customAlertView = CustomAlertView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = customAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        bindData()
    }
    
    private func bindData() {
        let input = CustomAlertViewModel.Input(cancelButtonTapped: customAlertView.cancelButton.rx.tap,
                                               confirmButtonTapped: customAlertView.confirmButton.rx.tap)
        let output = customAlertView.viewModel.transform(input: input)
        
        
        output.cancelButtonDriver
            .drive { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: customAlertView.viewModel.disposeBag)
        
        output.confirmButtonDriver
            .drive { [weak self] _ in
                guard let self = self else { return }
                switch self.customAlertView.state {
                case .sendRequest:
                    self.sendRequest()
                case .acceptRequest:
                    print("Accept Request Action")
                case .deleteAccount:
                    self.deleteAccount()
                    self.dismiss(animated: true)
                }
            }
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
    
    private func deleteAccount() {
        NetworkManager.shared.request(router: SeSacApiUser.withdraw)
            .subscribe(onSuccess: { data, status in
                print(data)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = SplashViewController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
                
                UserDefaultsManager.removeAll()
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.deleteAccount()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
    
    private func sendRequest() {
        NetworkManager.shared.request(router: SeSacApiQueue.sendRequest)
            .subscribe(onSuccess: { [weak self] data, status in
                print(data)
                guard let status = SesacStatus.Queue.StudyRequest(rawValue: status) else { return }
                switch status {
                case .success:
                    self?.view.makeToast("스터디 요청 메세지를 보냈습니다.")
                case .alreadyReceivedRequest:
                    self?.view.makeToast(status.errorDescription)
                case .userCanceledSeeking:
                    self?.view.makeToast(status.errorDescription)
                }
                self?.dismiss(animated: true)
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.sendRequest()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }

                default:
                    self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: customAlertView.viewModel.disposeBag)
    }

}
